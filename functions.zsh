#!/bin/zsh

projet() {
    if [ -z "$1" ]; then
        echo "Usage: projet <path/or/name> [php|laravel|nuxt]"
        echo "Examples:"
        echo "  projet /var/www/html/my-site"
        echo "  projet my-project laravel"
        echo "  projet project nuxt"
        return 1
    fi

    local target_path="$1"
    local project_type="$2"
    
    if [ ! -d "$target_path" ]; then
        echo "Searching for project: $target_path"
        local found_path=$(find /var/www/html ~/Documents ~/Projects \
            -type d -name "*$target_path*" \
            ! -path "*/vendor/*" \
            ! -path "*/storage/*" \
            ! -path "*/node_modules/*" \
            -print -quit 2>/dev/null)
        
        if [ -n "$found_path" ]; then
            target_path="$found_path"
            echo "Project found: $target_path"
        else
            echo "Project '$target_path' not found"
            return 1
        fi
    fi

    cd "$target_path"
    echo "Directory: $(pwd)"
    
    if command -v code &> /dev/null; then
        echo "Opening in VSCode..."
        code . > /dev/null 2>&1 &
    else
        echo "VSCode not installed or 'code' not in PATH"
    fi
    
    if [ -n "$project_type" ]; then
        case $project_type in
            laravel) _start_laravel ;;
            nuxt) _start_nuxt ;;
            php) _start_php ;;
            *) echo "Unknown type: $project_type (use: php, laravel, nuxt)"; return 1 ;;
        esac
    else
        echo "Tip: add 'laravel', 'nuxt', or 'php' to start automatically"
    fi
}

# ----------------------------------------------------
# STARTERS
# ----------------------------------------------------
_start_laravel() {
    echo "Starting Laravel..."
    if [ ! -f "artisan" ]; then
        echo "This is not a Laravel project (artisan not found)"
        return 1
    fi

    if lsof -ti:8000 > /dev/null 2>&1; then
        echo "Port 8000 already in use. Stop the existing process or use another port."
        return 1
    fi

    if [ -f "config/queue.php" ]; then
        echo "Starting queue worker in background..."
        php artisan queue:work --sleep=3 --tries=3 > storage/logs/queue.log 2>&1 &
        echo "Queue worker started (PID $!) — logs: storage/logs/queue.log"
    fi

    echo "Server running on: http://localhost:8000"
    _open_browser "http://localhost:8000" &   

    echo "Press Ctrl+C to stop the server."
    php artisan serve --host=0.0.0.0 --port=8000
}

_start_nuxt() {
    echo "Starting Nuxt.js..."
    if [ ! -f "nuxt.config.js" ] && [ ! -f "nuxt.config.ts" ]; then
        echo "This is not a Nuxt project (nuxt.config not found)"
        return 1
    fi

    if [ ! -d "node_modules" ]; then
        echo "Installing npm dependencies..."
        npm install
    fi

    if lsof -ti:3000 > /dev/null 2>&1; then
        echo "Port 3000 already in use. Stop the existing process or use another port."
        return 1
    fi

    echo "Server running on: http://localhost:3000"
    _open_browser "http://localhost:3000" &   

    echo "Press Ctrl+C to stop the server."
    npm run dev
}

_start_php() {
    echo "Starting PHP built-in server..."
    if ! find . -name "*.php" -type f | read; then
        echo "No PHP files found in this project"
        return 1
    fi

    if lsof -ti:8080 > /dev/null 2>&1; then
        echo "Port 8080 already in use. Stop the existing process or use another port."
        return 1
    fi

    echo "Server running on: http://localhost:8080"
    _open_browser "http://localhost:8080" &   

    echo "Press Ctrl+C to stop the server."
    php -S localhost:8080 -t .
}

# ----------------------------------------------------
# Browser function
# ----------------------------------------------------

_open_browser() {
    local url="$1"
    if command -v xdg-open &> /dev/null; then
        (sleep 4 && xdg-open "$url" > /dev/null 2>&1) &
    fi
}


# ----------------------------------------------------
# FUNCTIONS
# ----------------------------------------------------

_open_browser() {
    local url="$1"
    if command -v xdg-open &> /dev/null; then
        echo "Opening browser..."
        (sleep 3 && xdg-open "$url" > /dev/null 2>&1) &
    fi
}

devps() {
    echo "Active development processes:"
    echo "----------------------------------------"
    local laravel_pid=$(pgrep -f "php artisan serve")
    if [ -n "$laravel_pid" ]; then
        echo "Laravel (PID $laravel_pid): http://localhost:8000"
    fi
    local nuxt_pid=$(pgrep -f "npm run dev")
    if [ -n "$nuxt_pid" ]; then
        echo "Nuxt.js (PID $nuxt_pid): http://localhost:3000"
    fi
    local php_pid=$(pgrep -f "php -S localhost:8080")
    if [ -n "$php_pid" ]; then
        echo "PHP (PID $php_pid): http://localhost:8080"
    fi
    local queue_pid=$(pgrep -f "php artisan queue:work")
    if [ -n "$queue_pid" ]; then
        echo "Queue Worker (PID $queue_pid)"
    fi
    echo "----------------------------------------"
}

devstop() {
    echo "Stopping development services..."
    pkill -f "php artisan serve"
    pkill -f "npm run dev"
    pkill -f "php -S localhost:8080"
    pkill -f "php artisan queue:work"
    echo "All services stopped"
}

findprojet() {
    if [ -z "$1" ]; then
        echo "Usage: findprojet <name>"
        return 1
    fi
    
    echo "Searching for: $1"
    find /var/www/html ~/Documents \
        -type d -name "*$1*" \
        ! -path "*/vendor/*" \
        ! -path "*/storage/*" \
        ! -path "*/node_modules/*" \
        2>/dev/null
}

lsprojets() {
    echo "Recent projects (via z):"
    echo "---------------------------"
    z -l | grep -E "(www|html|projects|Projects)" | head -10
    echo "---------------------------"
    echo "Use: projet <name> [type] to open"
}

#echo " dev functions loaded!"
#echo "available commands: pj, pjs, pjstop, fp, lsp"
