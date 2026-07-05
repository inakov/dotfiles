#!/bin/bash
input=$(cat)

MODEL=$(echo "$input" | jq -r '.model.display_name')
DIR=$(echo "$input" | jq -r '.workspace.current_dir')
COST=$(echo "$input" | jq -r '.cost.total_cost_usd // 0')
PCT=$(echo "$input" | jq -r '.context_window.used_percentage // 0' | cut -d. -f1)
DURATION_MS=$(echo "$input" | jq -r '.cost.total_duration_ms // 0')

# Truecolor (RGB) escapes — immune to terminal palette remapping, unlike the
# basic 30-37 ANSI codes which themes can render as the wrong color.
CYAN='\033[38;2;86;182;194m'
GREEN='\033[38;2;87;194;99m'
YELLOW='\033[38;2;214;181;32m'
ORANGE='\033[38;2;219;138;43m'
RED='\033[38;2;224;76;76m'
RESET='\033[0m'

# Context-window zones tied to actual behavior:
#   <55%  healthy            (green)
#   55-75 watch              (yellow)
#   75-90 degradation risk / compact on your terms (orange)
#   >=90  auto-compact imminent (red)
if   [ "$PCT" -ge 90 ]; then BAR_COLOR="$RED"
elif [ "$PCT" -ge 75 ]; then BAR_COLOR="$ORANGE"
elif [ "$PCT" -ge 55 ]; then BAR_COLOR="$YELLOW"
else BAR_COLOR="$GREEN"; fi

FILLED=$((PCT / 10)); EMPTY=$((10 - FILLED))
printf -v FILL "%${FILLED}s"; printf -v PAD "%${EMPTY}s"
BAR="${FILL// /█}${PAD// /░}"

# Duration: days / hours / minutes / seconds, dropping leading zero units.
SECS_TOTAL=$((DURATION_MS / 1000))
D=$((SECS_TOTAL / 86400))
H=$(((SECS_TOTAL % 86400) / 3600))
M=$(((SECS_TOTAL % 3600) / 60))
S=$((SECS_TOTAL % 60))
if   [ "$D" -gt 0 ]; then DURATION="${D}d ${H}h ${M}m ${S}s"
elif [ "$H" -gt 0 ]; then DURATION="${H}h ${M}m ${S}s"
elif [ "$M" -gt 0 ]; then DURATION="${M}m ${S}s"
else DURATION="${S}s"; fi

BRANCH=""
git -C "$DIR" rev-parse --git-dir > /dev/null 2>&1 && BRANCH=" | 🌿 $(git -C "$DIR" branch --show-current 2>/dev/null)"

echo -e "${CYAN}[$MODEL]${RESET} 📁 ${DIR##*/}$BRANCH"
COST_FMT=$(printf '$%.2f' "$COST")
echo -e "${BAR_COLOR}${BAR}${RESET} ${PCT}% | ${YELLOW}${COST_FMT}${RESET} | ⏱️ ${DURATION}"
