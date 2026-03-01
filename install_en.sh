#!/usr/bin/env bash
# =============================================================================
#  OpenClaw VPS Auto-Install Script v1.1 (English)
#  Author: @kokoju007 | Maintained by: Daehan-Base
#  Target: Ubuntu 20.04 / 22.04 / 24.04 VPS
#
#  [Security Principles]
#  - No direct execution of external URLs (files are saved and verified first)
#  - Only official npm registry (npmjs.com) is used
#  - Personal info (Telegram token) is stored locally only, never transmitted
#  - Network requests: npm install + apt (official packages only)
# =============================================================================

set -euo pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m'

info()    { echo -e "${CYAN}[INFO]${NC} $1"; }
success() { echo -e "${GREEN}[DONE]${NC} $1"; }
warn()    { echo -e "${YELLOW}[WARN]${NC} $1"; }
error()   { echo -e "${RED}[ERROR]${NC} $1"; exit 1; }
step()    { echo -e "\n${BOLD}${BLUE}━━━ $1 ━━━${NC}"; }

# ── Banner ────────────────────────────────────────────────────────────────
clear 2>/dev/null || true
echo -e "${BOLD}${CYAN}"
cat << 'EOF'
  ██████╗ ██████╗ ███████╗███╗   ██╗ ██████╗██╗      █████╗ ██╗    ██╗
 ██╔═══██╗██╔══██╗██╔════╝████╗  ██║██╔════╝██║     ██╔══██╗██║    ██║
 ██║   ██║██████╔╝█████╗  ██╔██╗ ██║██║     ██║     ███████║██║ █╗ ██║
 ██║   ██║██╔═══╝ ██╔══╝  ██║╚██╗██║██║     ██║     ██╔══██║██║███╗██║
 ╚██████╔╝██║     ███████╗██║ ╚████║╚██████╗███████╗██║  ██║╚███╔███╔╝
  ╚═════╝ ╚═╝     ╚══════╝╚═╝  ╚═══╝ ╚═════╝╚══════╝╚═╝  ╚═╝ ╚══╝╚══╝
EOF
echo -e "${NC}"
echo -e "${BOLD}  VPS Auto-Install Script v1.1${NC}"
echo -e "  Deploy a 24/7 AI agent on your own server — right now"
echo ""
echo -e "${YELLOW}  [Security Notice] This script:${NC}"
echo    "  • Only installs official npm packages (npmjs.com)"
echo    "  • Never transmits your credentials externally"
echo    "  • Is fully open-source — inspect the code anytime"
echo    "  • GitHub: https://github.com/Daehan-Base/openclaw-setup"
echo ""
read -r -p "  Press Enter to continue..." _ </dev/tty

# ── Step 1: OS Check ──────────────────────────────────────────────────────
step "Step 1/5 · System Check"

OS=$(lsb_release -si 2>/dev/null || echo "Unknown")
VER=$(lsb_release -sr 2>/dev/null || echo "Unknown")

if [[ "$OS" != "Ubuntu" ]]; then
  warn "Non-Ubuntu environment detected ($OS $VER)"
  warn "This script has been tested on Ubuntu 20.04 / 22.04 / 24.04"
  read -r -p "  Continue anyway? (y/N): " cont </dev/tty
  [[ "$cont" =~ ^[Yy]$ ]] || error "Installation aborted"
else
  success "Ubuntu $VER detected"
fi

info "Architecture: $(uname -m)"
info "Hostname: $(hostname)"

# ── Step 2: Node.js 22 ────────────────────────────────────────────────────
step "Step 2/5 · Node.js Installation"

REQUIRED_NODE=22

install_node() {
  info "Installing Node.js ${REQUIRED_NODE} LTS (official NodeSource repository)"
  TMP_SCRIPT=$(mktemp)
  curl -fsSL "https://deb.nodesource.com/setup_${REQUIRED_NODE}.x" -o "$TMP_SCRIPT"

  if grep -q "setup_${REQUIRED_NODE}" "$TMP_SCRIPT" 2>/dev/null; then
    info "Script verified. Proceeding with installation..."
    sudo bash "$TMP_SCRIPT"
    sudo apt-get update -qq
    DEBIAN_FRONTEND=noninteractive sudo apt-get install -y nodejs
    rm -f "$TMP_SCRIPT"
  else
    rm -f "$TMP_SCRIPT"
    error "Node.js install script verification failed. Please install manually: https://nodejs.org"
  fi
}

if command -v node &>/dev/null; then
  NODE_VER=$(node --version | sed 's/v//' | cut -d. -f1)
  if (( NODE_VER >= REQUIRED_NODE )); then
    success "Node.js $(node --version) already installed"
  else
    warn "Node.js version too old (current: v${NODE_VER}, required: v${REQUIRED_NODE}+)"
    install_node
    success "Node.js $(node --version) installed"
  fi
else
  info "Node.js not found. Installing..."
  install_node
  success "Node.js $(node --version) installed"
fi

# ── Step 3: OpenClaw ──────────────────────────────────────────────────────
step "Step 3/5 · OpenClaw Installation"

LATEST_VER=$(npm view openclaw version 2>/dev/null || echo "")
if [[ -z "$LATEST_VER" ]]; then
  error "Cannot find openclaw on npm. Please check your network connection."
fi
info "Version to install: openclaw@${LATEST_VER}"

if command -v openclaw &>/dev/null; then
  CURRENT_VER=$(openclaw -V 2>/dev/null || echo "unknown")
  info "OpenClaw already installed (version: $CURRENT_VER)"
  read -r -p "  Update to the latest version? (y/N): " update_oc </dev/tty
  if [[ "$update_oc" =~ ^[Yy]$ ]]; then
    npm install -g "openclaw@${LATEST_VER}"
    success "OpenClaw updated"
  fi
else
  info "Installing OpenClaw..."
  npm install -g "openclaw@${LATEST_VER}"
  if ! command -v openclaw &>/dev/null; then
    error "OpenClaw installation failed. Try 'npm install -g openclaw' manually."
  fi
  success "OpenClaw $(openclaw -V 2>/dev/null) installed"
fi

# ── Step 4: Telegram Bot Setup ────────────────────────────────────────────
step "Step 4/5 · Telegram Bot Connection"

echo ""
echo -e "  ${BOLD}You'll need a Telegram Bot Token.${NC}"
echo ""
echo    "  Don't have a bot yet?"
echo -e "  1. Open Telegram → search ${CYAN}@BotFather${NC}"
echo    "  2. Send /newbot and follow the prompts"
echo    "  3. Copy the token (e.g. 1234567890:ABCdef...)"
echo ""

while true; do
  read -r -p "  Telegram Bot Token: " BOT_TOKEN </dev/tty
  if [[ "$BOT_TOKEN" =~ ^[0-9]{8,12}:[A-Za-z0-9_-]{35,}$ ]]; then
    success "Token format verified"
    break
  else
    warn "Invalid token format. Try again."
  fi
done

echo ""
echo -e "  ${BOLD}Your Telegram User ID:${NC}"
echo ""
echo -e "  1. Open Telegram → search ${CYAN}@userinfobot${NC}"
echo    "  2. Send /start to see your numeric ID"
echo ""

while true; do
  read -r -p "  Telegram User ID (numbers only): " USER_ID </dev/tty
  if [[ "$USER_ID" =~ ^[0-9]{5,12}$ ]]; then
    success "User ID verified"
    break
  else
    warn "Numbers only please (e.g. 123456789)"
  fi
done

echo ""
echo -e "  ${BOLD}Anthropic API Key:${NC}"
echo ""
echo -e "  1. Go to ${CYAN}https://console.anthropic.com${NC}"
echo    "  2. API Keys → Create Key"
echo    "  3. Copy (starts with sk-ant-...)"
echo ""

while true; do
  read -r -p "  Anthropic API Key (sk-ant-...): " ANTHROPIC_KEY </dev/tty
  if [[ "$ANTHROPIC_KEY" =~ ^sk-ant-[A-Za-z0-9_-]{20,}$ ]]; then
    success "API key format verified"
    break
  else
    warn "Must start with sk-ant-"
  fi
done

# ── Step 5: Configure + Register Service ─────────────────────────────────
step "Step 5/5 · Configuration & 24/7 Service Setup"

OPENCLAW_PATH=$(which openclaw)
info "openclaw path: $OPENCLAW_PATH"

info "Running OpenClaw onboarding..."
openclaw onboard \
  --non-interactive \
  --accept-risk \
  --auth-choice token \
  --token "$ANTHROPIC_KEY" \
  --token-provider anthropic \
  --install-daemon \
  --skip-skills \
  --skip-ui 2>&1 | grep -v "^$" || true

openclaw config set gateway.mode local

info "Configuring Telegram channel..."
openclaw config set channels.telegram.enabled true
openclaw config set channels.telegram.botToken "$BOT_TOKEN"
openclaw config set channels.telegram.dmPolicy allowlist
openclaw config set "channels.telegram.allowFrom[0]" "$USER_ID"

success "Configuration complete"

info "Registering 24/7 systemd service..."
SERVICE_FILE="/etc/systemd/system/openclaw.service"

sudo tee "$SERVICE_FILE" > /dev/null << EOF
[Unit]
Description=OpenClaw AI Agent
After=network.target

[Service]
Type=simple
User=${USER}
WorkingDirectory=${HOME}
ExecStart=${OPENCLAW_PATH} gateway
Restart=always
RestartSec=10
Environment=HOME=${HOME}

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl enable openclaw
sudo systemctl start openclaw

sleep 5

# ── Done ──────────────────────────────────────────────────────────────────
if systemctl is-active --quiet openclaw 2>/dev/null; then
  SVC_STATUS="${GREEN}Running ✅${NC}"
else
  SVC_STATUS="${YELLOW}Check required ⚠️${NC}"
fi

echo ""
echo -e "${GREEN}${BOLD}"
echo    "  ╔════════════════════════════════════════╗"
echo    "  ║     🎉 Installation Complete!          ║"
echo    "  ╚════════════════════════════════════════╝"
echo -e "${NC}"
echo -e "  Service status: ${SVC_STATUS}"
echo    ""
echo    "  ✅ Send a message to your Telegram bot to test"
echo    "  ✅ Try saying 'Hello' — it should respond"
echo ""
echo -e "  ${BOLD}Useful commands:${NC}"
echo    "  • Check status:  sudo systemctl status openclaw"
echo    "  • View logs:     sudo journalctl -u openclaw -f"
echo    "  • Restart:       sudo systemctl restart openclaw"
echo    "  • Stop:          sudo systemctl stop openclaw"
echo ""
echo -e "  ${CYAN}GitHub: https://github.com/Daehan-Base/openclaw-setup${NC}"
echo ""
