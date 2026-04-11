#!/usr/bin/env python3
"""
Daily Report AI Enhancement Script (BOS-AI library)

Enhances raw daily progress reports with AI-generated blog posts and social
media content. Output is shaped by a voice guide so the result reads like the
user wrote it, not like a generic AI.

Voice guide resolution (first match wins):
    1. Path in env var DAILYREPORT_VOICE_GUIDE
    2. ./voice-guide.md (current working directory)
    3. ./.claude/voice-guide.md
    4. voice-guide.md sitting next to this script (the default that ships
       with BOS-AI — Jamie Watters' voice)

Environment Variables:
    OPENAI_API_KEY: Required for AI enhancement features
    DAILYREPORT_ENABLE_SOCIAL: Enable social media generation (default: true)
    DAILYREPORT_BASE_URL: Base URL for links (default: jamiewatters.work)
    DAILYREPORT_VOICE_GUIDE: Override path to a custom voice guide
    DAILYREPORT_MODEL: Override the OpenAI model (default: gpt-4o-mini)

Usage:
    python enhance_dailyreport.py <input_file>
    python enhance_dailyreport.py progress/2025-11-29.md
"""

import os
import sys
import json
import re
from datetime import datetime
from pathlib import Path
from typing import Dict, Optional, Tuple

try:
    from openai import OpenAI
except ImportError:
    print("Error: openai package not installed")
    print("Install with: pip install openai")
    sys.exit(1)


SCRIPT_DIR = Path(__file__).resolve().parent


def load_voice_guide() -> Tuple[str, str]:
    """Find and read the voice guide. Returns (contents, source_path).

    Falls back through env var, project-level overrides, and the default
    that ships next to this script. If nothing is found, returns a minimal
    inline default and a synthetic source label.
    """
    candidates = []

    env_path = os.getenv('DAILYREPORT_VOICE_GUIDE')
    if env_path:
        candidates.append(Path(env_path).expanduser())

    cwd = Path.cwd()
    candidates.append(cwd / 'voice-guide.md')
    candidates.append(cwd / '.claude' / 'voice-guide.md')
    candidates.append(SCRIPT_DIR / 'voice-guide.md')

    for path in candidates:
        try:
            if path.is_file():
                return path.read_text(), str(path)
        except OSError:
            continue

    fallback = (
        "Write in first person. British spelling. Concrete specifics over "
        "adjectives. Vary sentence and paragraph length. Open in the middle "
        "of the situation. Close with a specific next action or a real "
        "question. No AI tell vocabulary (delve, leverage, robust, seamless, "
        "transformative, etc). No bullet points with bolded headers. No "
        "compulsive summary at the end."
    )
    return fallback, "<built-in fallback>"


class DailyReportEnhancer:
    """Enhances daily progress reports with AI-generated content."""

    def __init__(self):
        self.api_key = os.getenv('OPENAI_API_KEY')
        if not self.api_key:
            raise ValueError(
                "OPENAI_API_KEY environment variable not set. "
                "Get your key from: https://platform.openai.com/api-keys"
            )

        self.client = OpenAI(api_key=self.api_key)
        self.model = os.getenv('DAILYREPORT_MODEL', 'gpt-4o-mini')

        self.enable_social = os.getenv('DAILYREPORT_ENABLE_SOCIAL', 'true').lower() == 'true'
        self.base_url = os.getenv('DAILYREPORT_BASE_URL', 'jamiewatters.work')

        self.voice_guide, self.voice_guide_source = load_voice_guide()

    def parse_raw_report(self, content: str) -> Dict:
        data = {
            'project': 'Unknown Project',
            'date': datetime.now().strftime('%Y-%m-%d'),
            'deliverables': [],
            'issues': [],
            'next_steps': []
        }

        project_match = re.search(r'#\s+([^\n]+)\s+Progress', content)
        if project_match:
            data['project'] = project_match.group(1).strip()

        date_match = re.search(r'\*\*Date\*\*:\s+(\d{4}-\d{2}-\d{2})', content)
        if date_match:
            data['date'] = date_match.group(1)

        deliverables_section = re.search(
            r'##\s+Deliverables.*?(?=##|$)', content, re.DOTALL
        )
        if deliverables_section:
            items = re.findall(r'-\s+\*\*([^*]+)\*\*:([^\n]+)', deliverables_section.group(0))
            data['deliverables'] = [
                {'title': title.strip(), 'description': desc.strip()}
                for title, desc in items
            ]

        issues_section = re.search(
            r'##\s+Issues.*?(?=##|$)', content, re.DOTALL
        )
        if issues_section:
            issue_blocks = re.findall(
                r'###\s+([^\n]+).*?(?=###|##|$)',
                issues_section.group(0),
                re.DOTALL
            )
            for block in issue_blocks:
                data['issues'].append(block.strip())

        next_section = re.search(
            r'##\s+Next.*?(?=##|$)', content, re.DOTALL
        )
        if next_section:
            items = re.findall(r'-\s+([^\n]+)', next_section.group(0))
            data['next_steps'] = [item.strip() for item in items if item.strip()]

        return data

    def _source_block(self, data: Dict) -> str:
        return (
            f"Project: {data['project']}\n"
            f"Date: {data['date']}\n\n"
            f"Deliverables:\n{self._format_deliverables(data['deliverables'])}\n\n"
            f"Issues:\n{self._format_issues(data['issues'])}\n\n"
            f"Next steps:\n{self._format_next_steps(data['next_steps'])}"
        )

    def generate_blog_prompt(self, data: Dict) -> str:
        return f"""You are drafting a blog post for the author described in the VOICE GUIDE
below. The piece must read like the author wrote it themselves. Not "AI-assisted
author." Not "author but smoother." Them. Follow every rule in the voice guide.

==================== VOICE GUIDE ====================
{self.voice_guide}
==================== END VOICE GUIDE ====================

SOURCE MATERIAL FROM TODAY'S RAW PROGRESS REPORT
{self._source_block(data)}

WHAT TO WRITE
- 500-900 words. Shorter is better than longer if the material doesn't fill it.
- Open in the middle of the situation or the tension. No preamble.
- Structure follows the work: situation → what broke or what you tried →
  what you learned → what you'll do next. Use H2 (##) headers only when the
  reader genuinely needs a signpost. Prose first.
- Title is an H1. No subtitle. No marketing flourish.
- Close with a specific next action, a real question, or both.

OUTPUT
Return only the blog post in markdown. No preamble, no "here is your post."
Run the voice guide rules against your draft before returning. If a sentence
fails any rule, rewrite it. Then read the whole thing back silently. If it
feels like an AI trying to sound like the author, delete the try-hard bits
and let the content breathe."""

    def generate_social_media_prompt(self, data: Dict) -> str:
        progress_link = f"https://{self.base_url}/progress/{data['date']}"

        return f"""You are drafting social media posts for the author described in the VOICE
GUIDE below. The posts must read like the author wrote them. Every voice rule
applies, including the banned vocabulary and constructions, even at short
length.

==================== VOICE GUIDE ====================
{self.voice_guide}
==================== END VOICE GUIDE ====================

SOURCE MATERIAL FROM TODAY'S RAW PROGRESS REPORT
{self._source_block(data)}

Progress link to include in both posts: {progress_link}

PLATFORM REQUIREMENTS

1. TWITTER / X
   - 280 character HARD LIMIT including the link and hashtags. Aim for 180-260.
   - First line is a hook: specific, slightly surprising, no flourish.
   - One concrete number or specific somewhere in the post.
   - 0-2 hashtags max from: #buildinpublic #solofounder #indiehacker #devlog
   - Include the progress link.
   - No emoji unless the voice guide explicitly permits them.
   - No "Shipped X today 🚀" template patterns. The hook should come from
     the actual material, not a stock format.

2. LINKEDIN
   - 800-1000 characters in the sweet spot, 3000 hard limit.
   - First 140 characters MUST be a hook that earns the click on "see more."
     Drop the reader into the middle of something. No "Today I want to share."
   - Short paragraphs. One idea per line where it helps scanning.
   - Include the progress link.
   - 0-3 hashtags total at the end. LinkedIn dislikes hashtag spam.
   - End with a real question, not a manufactured engagement prompt.
   - No emoji.
   - The register is "smart colleague sharing a real lesson," not "thought
     leader dropping wisdom."

OUTPUT FORMAT
Return ONLY valid JSON in this exact shape, nothing else:
{{
  "twitter": {{
    "content": "The complete tweet text with link and hashtags",
    "character_count": 145,
    "hashtags": ["buildinpublic"]
  }},
  "linkedin": {{
    "content": "The complete LinkedIn post with link and hashtags",
    "character_count": 876,
    "hook": "First 140 characters of the post",
    "hook_length": 98,
    "has_question": true
  }}
}}

RULES
- Return ONLY the JSON object. No markdown fences, no commentary.
- Twitter content under 280 characters including link and hashtags.
- LinkedIn hook under 140 characters.
- Count characters accurately.
- Run the voice guide against both posts before returning. If a phrase fails,
  rewrite it."""

    def _format_deliverables(self, deliverables: list) -> str:
        if not deliverables:
            return "None"
        return "\n".join(
            f"- {d['title']}: {d['description']}"
            for d in deliverables
        )

    def _format_issues(self, issues: list) -> str:
        if not issues:
            return "None"
        return "\n".join(f"- {issue}" for issue in issues)

    def _format_next_steps(self, next_steps: list) -> str:
        if not next_steps:
            return "None"
        return "\n".join(f"- {step}" for step in next_steps)

    def generate_blog_content(self, raw_content: str) -> str:
        data = self.parse_raw_report(raw_content)
        prompt = self.generate_blog_prompt(data)

        print("\n🤖 Generating blog post with AI...")

        try:
            response = self.client.chat.completions.create(
                model=self.model,
                messages=[
                    {
                        "role": "system",
                        "content": (
                            "You ghostwrite for a specific human author. Your only "
                            "job is to produce a draft they would recognise as theirs. "
                            "The voice guide in the user message is binding: every rule, "
                            "every banned word, every construction. If you cannot honour "
                            "a rule for a given sentence, rewrite the sentence."
                        )
                    },
                    {"role": "user", "content": prompt}
                ],
                temperature=0.6,
                max_tokens=1800
            )

            blog_content = response.choices[0].message.content.strip()
            print("✅ Blog post generated successfully")
            return blog_content

        except Exception as e:
            raise Exception(f"Failed to generate blog content: {str(e)}")

    def generate_social_content(self, raw_content: str) -> Dict:
        data = self.parse_raw_report(raw_content)
        prompt = self.generate_social_media_prompt(data)

        print("\n🐦 Generating social media posts with AI...")

        try:
            response = self.client.chat.completions.create(
                model=self.model,
                messages=[
                    {
                        "role": "system",
                        "content": (
                            "You ghostwrite social posts for a specific human author. "
                            "The voice guide in the user message is binding. Banned "
                            "vocabulary applies even at short length. Return only "
                            "valid JSON in the requested shape."
                        )
                    },
                    {"role": "user", "content": prompt}
                ],
                temperature=0.6,
                max_tokens=1200
            )

            raw_response = response.choices[0].message.content.strip()

            json_content = raw_response
            if raw_response.startswith('```'):
                json_match = re.search(r'```(?:json)?\n(.*?)```', raw_response, re.DOTALL)
                if json_match:
                    json_content = json_match.group(1).strip()

            social_data = json.loads(json_content)

            if 'twitter' not in social_data or 'linkedin' not in social_data:
                raise ValueError("Response missing required 'twitter' or 'linkedin' keys")

            twitter_count = social_data['twitter'].get('character_count', 0)
            if twitter_count > 280:
                print(f"⚠️  Warning: Twitter post is {twitter_count} chars (limit: 280)")

            hook_length = social_data['linkedin'].get('hook_length', 0)
            if hook_length > 140:
                print(f"⚠️  Warning: LinkedIn hook is {hook_length} chars (limit: 140)")

            print("✅ Social media posts generated successfully")
            return social_data

        except json.JSONDecodeError as e:
            raise Exception(f"Failed to parse JSON response: {str(e)}\nRaw response: {raw_response}")
        except Exception as e:
            raise Exception(f"Failed to generate social content: {str(e)}")

    def format_blog_output(self, content: str, date: str, project: str) -> str:
        date_obj = datetime.strptime(date, '%Y-%m-%d')
        formatted_date = date_obj.strftime('%B %d, %Y')

        return f"""---
date: {date}
project: {project}
generated: {datetime.now().strftime('%Y-%m-%d %H:%M')}
voice_guide: {self.voice_guide_source}
---

{content}

---

*This post was AI-enhanced from daily progress logs using /dailyreport.*
*Voice guide: {self.voice_guide_source}*
"""

    def format_twitter_output(self, data: Dict, date: str, project: str) -> str:
        date_obj = datetime.strptime(date, '%Y-%m-%d')
        formatted_date = date_obj.strftime('%B %d, %Y')

        content = data.get('content', '')
        char_count = data.get('character_count', len(content))
        hashtags = data.get('hashtags', [])

        char_status = "✅" if char_count <= 280 else "⚠️"
        hashtag_status = "✅" if len(hashtags) <= 2 else "⚠️"
        has_link = self.base_url in content or 'http' in content

        return f"""# Twitter/X Post - {formatted_date}

**Project**: {project}
**Characters**: {char_count}/280

---

{content}

---

**Copy-paste ready** ⬆️

## Optimisation notes
- Character count: {char_count}/280 {char_status}
- Hashtags: {len(hashtags)}/2 {hashtag_status}
- Link included: {'Yes' if has_link else 'No'}
- Voice guide: {self.voice_guide_source}

*Generated by /dailyreport on {datetime.now().strftime('%B %d, %Y at %H:%M')}*
"""

    def format_linkedin_output(self, data: Dict, date: str, project: str) -> str:
        date_obj = datetime.strptime(date, '%Y-%m-%d')
        formatted_date = date_obj.strftime('%B %d, %Y')

        content = data.get('content', '')
        char_count = data.get('character_count', len(content))
        hook = data.get('hook', '')
        hook_length = data.get('hook_length', len(hook))
        has_question = data.get('has_question', False)

        total_status = "✅" if char_count <= 3000 else "⚠️"
        hook_status = "✅" if hook_length <= 140 else "⚠️"
        has_link = self.base_url in content or 'http' in content

        return f"""# LinkedIn Post - {formatted_date}

**Project**: {project}
**Characters**: {char_count}/3000
**Hook Length**: {hook_length}/140 chars

---

{content}

---

**Copy-paste ready** ⬆️

## Optimisation notes
- Total characters: {char_count}/3000 {total_status}
- Hook length: {hook_length}/140 {hook_status}
- Engagement question: {'Yes' if has_question else 'No'}
- Link included: {'Yes' if has_link else 'No'}
- Voice guide: {self.voice_guide_source}

*Generated by /dailyreport on {datetime.now().strftime('%B %d, %Y at %H:%M')}*
"""


def process_file(input_path: str) -> Tuple[str, Optional[str], Optional[str]]:
    input_file = Path(input_path)
    if not input_file.exists():
        raise FileNotFoundError(f"Input file not found: {input_path}")

    print(f"📄 Reading: {input_file.name}")
    raw_content = input_file.read_text()

    try:
        enhancer = DailyReportEnhancer()
    except ValueError as e:
        print(f"\n❌ {str(e)}")
        print("\nTo enable AI enhancement:")
        print("1. Get an OpenAI API key: https://platform.openai.com/api-keys")
        print("2. Set environment variable: export OPENAI_API_KEY='your-key'")
        print("3. Run the command again")
        return (str(input_file), None, None)

    print(f"🎙  Voice guide: {enhancer.voice_guide_source}")

    data = enhancer.parse_raw_report(raw_content)
    project = data['project']
    date = data['date']

    try:
        blog_content = enhancer.generate_blog_content(raw_content)
        formatted_blog = enhancer.format_blog_output(blog_content, date, project)

        blog_output = input_file.parent / f"{date}-blog.md"
        blog_output.write_text(formatted_blog)
        print(f"✅ Blog saved: {blog_output.name}")

    except Exception as e:
        print(f"❌ Blog generation failed: {str(e)}")
        return (str(input_file), None, None)

    twitter_output_path = None
    linkedin_output_path = None

    if enhancer.enable_social:
        try:
            social_data = enhancer.generate_social_content(raw_content)

            twitter_content = enhancer.format_twitter_output(
                social_data['twitter'], date, project
            )
            twitter_output = input_file.parent / f"{date}-twitter.md"
            twitter_output.write_text(twitter_content)
            twitter_output_path = str(twitter_output)
            print(f"✅ Twitter post saved: {twitter_output.name}")

            linkedin_content = enhancer.format_linkedin_output(
                social_data['linkedin'], date, project
            )
            linkedin_output = input_file.parent / f"{date}-linkedin.md"
            linkedin_output.write_text(linkedin_content)
            linkedin_output_path = str(linkedin_output)
            print(f"✅ LinkedIn post saved: {linkedin_output.name}")

            print("\n" + "="*60)
            print("TWITTER PREVIEW (copy-paste ready):")
            print("="*60)
            print(social_data['twitter']['content'])
            print("="*60)

        except Exception as e:
            print(f"⚠️  Social media generation failed: {str(e)}")
            print("   Blog post was created successfully.")
    else:
        print("ℹ️  Social media generation disabled (DAILYREPORT_ENABLE_SOCIAL=false)")

    return (str(blog_output), twitter_output_path, linkedin_output_path)


def main():
    if len(sys.argv) != 2:
        print("Usage: python enhance_dailyreport.py <input_file>")
        print("Example: python enhance_dailyreport.py progress/2025-11-29.md")
        sys.exit(1)

    input_path = sys.argv[1]

    print("\n" + "="*60)
    print("DAILY REPORT AI ENHANCEMENT")
    print("="*60)

    try:
        blog_path, twitter_path, linkedin_path = process_file(input_path)

        print("\n" + "="*60)
        print("GENERATION COMPLETE")
        print("="*60)
        print(f"\n📝 Blog post: {blog_path}")
        if twitter_path:
            print(f"🐦 Twitter post: {twitter_path}")
        if linkedin_path:
            print(f"💼 LinkedIn post: {linkedin_path}")
        print("\n✨ Ready to publish!\n")

    except Exception as e:
        print(f"\n❌ Error: {str(e)}\n")
        sys.exit(1)


if __name__ == "__main__":
    main()
