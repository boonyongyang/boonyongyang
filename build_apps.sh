#!/bin/bash

# Build script for deploying different app versions

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to build landing page
build_landing() {
    print_status "Building landing page..."
    APP_URL="${APP_URL:-https://app.boonyongyang.com}"
    SITE_URL="${SITE_URL:-https://boonyongyang.com}"
    PORTFOLIO_3D_URL="${PORTFOLIO_3D_URL:-https://3d.boonyongyang.com}"
    PORTFOLIO_V4_URL="${PORTFOLIO_V4_URL:-https://v4.boonyongyang.com}"
    GITHUB_URL="${GITHUB_URL:-https://github.com/boonyongyang}"
    LINKEDIN_URL="${LINKEDIN_URL:-https://linkedin.com/in/boonyongyang}"
    ANALYTICS_MEASUREMENT_ID="${ANALYTICS_MEASUREMENT_ID:-}"
    GOOGLE_SITE_VERIFICATION="${GOOGLE_SITE_VERIFICATION:-}"
    
    # Create landing page build with optimizations
    flutter build web \
        --target=lib/main_landing.dart \
        --output=build/landing \
        --web-renderer=html \
        --dart-define=APP_MODE=landing \
        --dart-define=APP_URL="$APP_URL" \
        --dart-define=SITE_URL="$SITE_URL" \
        --dart-define=PORTFOLIO_3D_URL="$PORTFOLIO_3D_URL" \
        --dart-define=PORTFOLIO_V4_URL="$PORTFOLIO_V4_URL" \
        --dart-define=GITHUB_URL="$GITHUB_URL" \
        --dart-define=LINKEDIN_URL="$LINKEDIN_URL" \
        --tree-shake-icons \
        --release
    
    # Copy custom HTML if it exists
    if [ -f "web/landing.html" ]; then
        cp web/landing.html build/landing/index.html
        print_status "Custom landing HTML applied"
    fi
    
    node tool/configure_flutter_web.mjs \
        build/landing "$SITE_URL" v1 "$ANALYTICS_MEASUREMENT_ID" "$GOOGLE_SITE_VERIFICATION"
    
    print_status "Landing page built successfully in build/landing"
}

# Function to build main app
build_main_app() {
    print_status "Building main app..."
    APP_URL="${APP_URL:-https://app.boonyongyang.com}"
    SITE_URL="${SITE_URL:-https://boonyongyang.com}"
    PORTFOLIO_3D_URL="${PORTFOLIO_3D_URL:-https://3d.boonyongyang.com}"
    PORTFOLIO_V4_URL="${PORTFOLIO_V4_URL:-https://v4.boonyongyang.com}"
    ANALYTICS_MEASUREMENT_ID="${ANALYTICS_MEASUREMENT_ID:-}"
    GOOGLE_SITE_VERIFICATION="${GOOGLE_SITE_VERIFICATION:-}"
    
    # Create main app build
    flutter build web \
        --target=lib/main_app.dart \
        --output=build/app \
        --web-renderer=html \
        --dart-define=APP_MODE=main_app \
        --dart-define=APP_URL="$APP_URL" \
        --dart-define=SITE_URL="$SITE_URL" \
        --dart-define=PORTFOLIO_3D_URL="$PORTFOLIO_3D_URL" \
        --dart-define=PORTFOLIO_V4_URL="$PORTFOLIO_V4_URL" \
        --release

    node tool/configure_flutter_web.mjs \
        build/app "$APP_URL" v2 "$ANALYTICS_MEASUREMENT_ID" "$GOOGLE_SITE_VERIFICATION"
    
    print_status "Main app built successfully in build/app"
}

# Function to build both
build_all() {
    print_status "Building all apps..."
    build_landing
    build_main_app
    print_status "All apps built successfully!"
}

# Function to show help
show_help() {
    echo "Flutter Multi-App Build Script"
    echo ""
    echo "Usage: $0 [OPTION]"
    echo ""
    echo "Options:"
    echo "  landing     Build landing page only"
    echo "  app         Build main app only"
    echo "  all         Build all apps (default)"
    echo "  help        Show this help message"
    echo ""
    echo "Output:"
    echo "  Landing page: build/landing/"
    echo "  Main app:     build/app/"
}

# Main script logic
case ${1:-all} in
    landing)
        build_landing
        ;;
    app)
        build_main_app
        ;;
    all)
        build_all
        ;;
    help|--help|-h)
        show_help
        ;;
    *)
        print_error "Unknown option: $1"
        show_help
        exit 1
        ;;
esac
