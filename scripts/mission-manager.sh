#!/bin/bash

# BOS-AI Mission Manager
# Utilities for managing mission state files

MISSION_DIR="/Users/jamiewatters/DevProjects/BOS-AI/workspace/missions"

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Function: Show mission status
mission_status() {
    echo -e "${GREEN}═══════════════════════════════════════════════${NC}"
    echo -e "${GREEN}       BOS-AI Mission Status Dashboard         ${NC}"
    echo -e "${GREEN}═══════════════════════════════════════════════${NC}"
    
    echo -e "\n${YELLOW}📋 Active Missions:${NC}"
    if [ -d "$MISSION_DIR/active" ] && [ "$(ls -A $MISSION_DIR/active 2>/dev/null)" ]; then
        for mission in "$MISSION_DIR"/active/*.md; do
            if [ -f "$mission" ]; then
                basename "$mission" .md
                grep "^**Status**:" "$mission" 2>/dev/null | head -1
                grep "^**Command**:" "$mission" 2>/dev/null | head -1
                echo "---"
            fi
        done
    else
        echo "  No active missions"
    fi
    
    echo -e "\n${YELLOW}⏸️  Paused Missions:${NC}"
    if [ -d "$MISSION_DIR/paused" ] && [ "$(ls -A $MISSION_DIR/paused 2>/dev/null)" ]; then
        for mission in "$MISSION_DIR"/paused/*.md; do
            if [ -f "$mission" ]; then
                basename "$mission" .md
                echo "---"
            fi
        done
    else
        echo "  No paused missions"
    fi
    
    echo -e "\n${YELLOW}✅ Recent Completed (last 5):${NC}"
    if [ -d "$MISSION_DIR/completed" ] && [ "$(ls -A $MISSION_DIR/completed 2>/dev/null)" ]; then
        ls -t "$MISSION_DIR"/completed/*.md 2>/dev/null | head -5 | while read mission; do
            if [ -f "$mission" ]; then
                basename "$mission" .md
            fi
        done
    else
        echo "  No completed missions"
    fi
}

# Function: Resume most recent active mission
mission_resume() {
    echo -e "${GREEN}Checking for active missions...${NC}"
    
    if [ -d "$MISSION_DIR/active" ] && [ "$(ls -A $MISSION_DIR/active 2>/dev/null)" ]; then
        latest=$(ls -t "$MISSION_DIR"/active/*.md 2>/dev/null | head -1)
        if [ -f "$latest" ]; then
            echo -e "${YELLOW}Found active mission:${NC}"
            basename "$latest" .md
            echo ""
            echo "Mission details:"
            grep "^## Mission Objective" -A 2 "$latest"
            echo ""
            echo -e "${GREEN}To resume this mission, run:${NC}"
            echo "  /coord --resume"
            echo ""
            echo "Mission file: $latest"
        fi
    else
        echo "No active missions to resume"
    fi
}

# Function: Pause active mission
mission_pause() {
    local mission_id="$1"
    
    if [ -z "$mission_id" ]; then
        # Find most recent active mission
        if [ -d "$MISSION_DIR/active" ] && [ "$(ls -A $MISSION_DIR/active 2>/dev/null)" ]; then
            latest=$(ls -t "$MISSION_DIR"/active/*.md 2>/dev/null | head -1)
            mission_id=$(basename "$latest" .md)
        else
            echo "No active mission to pause"
            return 1
        fi
    fi
    
    source_file="$MISSION_DIR/active/${mission_id}.md"
    if [ -f "$source_file" ]; then
        # Update status in file
        sed -i '' 's/^\*\*Status\*\*: active/\*\*Status\*\*: paused/' "$source_file"
        # Move to paused directory
        mv "$source_file" "$MISSION_DIR/paused/"
        echo -e "${YELLOW}Mission paused: $mission_id${NC}"
        echo "Moved to: $MISSION_DIR/paused/"
    else
        echo -e "${RED}Mission not found: $mission_id${NC}"
        return 1
    fi
}

# Function: Complete mission
mission_complete() {
    local mission_id="$1"
    
    if [ -z "$mission_id" ]; then
        echo "Usage: mission_complete <mission-id>"
        return 1
    fi
    
    source_file="$MISSION_DIR/active/${mission_id}.md"
    if [ -f "$source_file" ]; then
        # Update status in file
        sed -i '' 's/^\*\*Status\*\*: active/\*\*Status\*\*: completed/' "$source_file"
        # Add completion timestamp
        echo -e "\n**Completed**: $(date '+%Y-%m-%d %H:%M:%S')" >> "$source_file"
        # Move to completed directory
        mv "$source_file" "$MISSION_DIR/completed/"
        echo -e "${GREEN}✅ Mission completed: $mission_id${NC}"
        
        # Update mission index
        # (In practice, this would be done by the coord command)
    else
        echo -e "${RED}Mission not found: $mission_id${NC}"
        return 1
    fi
}

# Function: Clean up old missions (archive >30 days)
mission_cleanup() {
    echo -e "${YELLOW}Archiving missions older than 30 days...${NC}"
    
    # Create archive directory if needed
    mkdir -p "$MISSION_DIR/archive"
    
    # Find and move old completed missions
    if [ -d "$MISSION_DIR/completed" ]; then
        find "$MISSION_DIR/completed" -name "*.md" -type f -mtime +30 -exec mv {} "$MISSION_DIR/archive/" \; 2>/dev/null
        echo "Archived old completed missions"
    fi
    
    # Remove very old archives (>90 days)
    if [ -d "$MISSION_DIR/archive" ]; then
        find "$MISSION_DIR/archive" -name "*.md" -type f -mtime +90 -delete 2>/dev/null
        echo "Removed archives older than 90 days"
    fi
}

# Function: Show mission details
mission_detail() {
    local mission_id="$1"
    
    if [ -z "$mission_id" ]; then
        echo "Usage: mission_detail <mission-id>"
        return 1
    fi
    
    # Search in all directories
    for dir in active paused completed; do
        file="$MISSION_DIR/$dir/${mission_id}.md"
        if [ -f "$file" ]; then
            echo -e "${GREEN}Mission found in: $dir${NC}"
            echo "═══════════════════════════════════════════════"
            cat "$file"
            return 0
        fi
    done
    
    echo -e "${RED}Mission not found: $mission_id${NC}"
    return 1
}

# Main script logic
case "${1:-status}" in
    status)
        mission_status
        ;;
    resume)
        mission_resume
        ;;
    pause)
        mission_pause "$2"
        ;;
    complete)
        mission_complete "$2"
        ;;
    cleanup)
        mission_cleanup
        ;;
    detail)
        mission_detail "$2"
        ;;
    help)
        echo "BOS-AI Mission Manager"
        echo ""
        echo "Usage: $0 [command] [options]"
        echo ""
        echo "Commands:"
        echo "  status    - Show all mission statuses (default)"
        echo "  resume    - Show most recent active mission"
        echo "  pause [id] - Pause active mission"
        echo "  complete <id> - Mark mission as completed"
        echo "  cleanup   - Archive old missions"
        echo "  detail <id> - Show full mission details"
        echo "  help      - Show this help message"
        ;;
    *)
        echo "Unknown command: $1"
        echo "Run '$0 help' for usage information"
        exit 1
        ;;
esac