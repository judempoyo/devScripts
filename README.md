# devScripts - Development Tools & Aliases for Zsh

A comprehensive collection of Zsh scripts, functions, and aliases to enhance your development workflow. Includes project management, service starters for Laravel/Nuxt/PHP, and Docker utilities.

## 📋 Table of Contents
- [Installation](#installation)
- [Setup](#setup)
- [Functions](#functions)
- [Aliases](#aliases)
- [Usage Examples](#usage-examples)
- [Contributing](#contributing)
- [License](#license)

## 🚀 Installation

### Prerequisites
- **Zsh** shell installed
- **Git** for cloning the repository

### Install Zsh (if not already installed)

```zsh
# Ubuntu/Debian
sudo apt install zsh

# macOS
brew install zsh

# Set Zsh as default shell
chsh -s $(which zsh)
```

### Clone the Repository

```zsh
git clone https://github.com/judempoyo/devScripts.git
cd devScripts
```

## 🔧 Setup

### Option 1: Source files in `.zshrc`

Add these lines to your `~/.zshrc` file:

```zsh
# Load development scripts
source ~/path/to/devScripts/aliases.zsh
source ~/path/to/devScripts/functions.zsh
```

### Option 2: Symlink (Recommended)

```zsh
mkdir -p ~/.zsh
ln -s ~/path/to/devScripts/aliases.zsh ~/.zsh/aliases.zsh
ln -s ~/path/to/devScripts/functions.zsh ~/.zsh/functions.zsh
```

Then add to `~/.zshrc`:

```zsh
source ~/.zsh/aliases.zsh
source ~/.zsh/functions.zsh
```

### Apply Changes

```zsh
source ~/.zshrc
```

## ⚡ Functions

### Project Management

#### `projet <path|name> [type]`
Opens a project and optionally starts a development server.

**Parameters:**
- `<path|name>`: Full path or project name (searches in `/var/www/html`, `~/Documents`, `~/Projects`)
- `[type]`: Optional - `laravel`, `nuxt`, or `php`

**Examples:**
```zsh
projet /var/www/html/my-site
projet my-project laravel
projet project nuxt
```

**Features:**
- Opens VSCode automatically if installed
- Starts Laravel with queue worker (if configured)
- Installs npm dependencies for Nuxt projects
- Checks for port conflicts

#### `devps`
Display all active development processes (Laravel, Nuxt, PHP, Queue Workers).

```zsh
devps
```

**Output Example:**
```
Active development processes:
----------------------------------------
Laravel (PID 1234): http://localhost:8000
Nuxt.js (PID 5678): http://localhost:3000
Queue Worker (PID 9012)
----------------------------------------
```

#### `devstop`
Stop all running development services.

```zsh
devstop
```

Stops: Laravel, Nuxt, PHP built-in server, and Queue Worker

#### `findprojet <name>`
Search for projects by name in standard directories.

```zsh
findprojet my-project
```

Searches in: `/var/www/html`, `~/Documents`, `~/Projects`

Excludes: `vendor/`, `storage/`, `node_modules/`

#### `lsprojets`
List recently accessed projects (requires `z` installation).

```zsh
lsprojets
```

### Starter Functions (Private)

#### `_start_laravel`
Automatically starts Laravel development server with queue worker support.

- Port: `8000`
- Queue logs: `storage/logs/queue.log`
- Auto-opens browser

#### `_start_nuxt`
Starts Nuxt.js development server with npm dependency check.

- Port: `3000`
- Auto-installs dependencies if missing
- Auto-opens browser

#### `_start_php`
Runs PHP built-in development server.

- Port: `8080`
- Serves current directory

---

## 📌 Aliases

### PHP & Laravel
```zsh
pa              # php artisan
pas             # php artisan serve
crd             # composer run dev
```

### NPM
```zsh
nrd             # npm run dev
ni              # npm install
nrg             # npm run generate
nrb             # npm run build
```

### System
```zsh
update          # sudo apt update && sudo apt upgrade -y
i               # sudo apt install
..              # cd ..
...             # cd ../..
```

### Project Navigation (Zoxide - z command)
```zsh
zz              # z -l (list recent paths)
zc              # z -c (remove invalid paths)
zf              # z -I (no interactive search)
```

### Project Shortcuts
```zsh
pj              # projet (open project)
pjs             # devps (show processes)
pjstop          # devstop (stop services)
fp              # findprojet (search project)
lsp             # lsprojets (list projects)
pjlaravel       # projet $1 laravel
pjnuxt          # projet $1 nuxt
pjphp           # projet $1 php
```

### Docker - Basic Commands
```zsh
d               # docker
dc              # docker compose
dps             # docker ps
dpsa            # docker ps -a
di              # docker images
```

### Docker - Container Management
```zsh
dlog            # docker logs
dlogf           # docker logs -f (follow)
dexec           # docker exec -it
dinspect        # docker inspect
dtop            # docker top
```

### Docker - Compose
```zsh
dcu             # docker compose up
dcud            # docker compose up -d
dcd             # docker compose down
dcb             # docker compose build
dcr             # docker compose restart
dcl             # docker compose logs
dclf            # docker compose logs -f
dcps            # docker compose ps
```

### Docker - Cleanup
```zsh
dstopall        # Stop all containers
drmd            # Remove stopped containers
drmc            # Prune containers
drmiunused      # Prune unused images
dvolprune       # Prune unused volumes
dnetprune       # Prune unused networks
dclean          # Full system prune with volumes
```

### Docker - Inspection & Debug
```zsh
dip             # Get container IP address
dports          # Show port mappings
dstats          # Show container stats
```

### Docker - Build & Registry
```zsh
dbuild          # docker build
dtag            # docker tag
dpush           # docker push
dpull           # docker pull
```

### Docker - Run
```zsh
dr             # docker run --rm -it
dlast           # Execute sh in last container
```

### Dev Tools (Custom Paths)
```zsh
devtools-code   # Open devtools in VSCode
devtools-up     # Start devtools docker compose
devtools-down   # Stop devtools docker compose
```

---

## 💡 Usage Examples

### Example 1: Start a Laravel Project
```zsh
pj my-laravel-app laravel
# Opens VSCode, starts Laravel server (port 8000), and starts queue worker
```

### Example 2: Start a Nuxt Project
```zsh
pj ~/Documents/nuxt-app nuxt
# Installs dependencies, starts dev server (port 3000), opens browser
```

### Example 3: Find and Open a Project
```zsh
fp my-project
pj my-project
```

### Example 4: Check Running Services
```zsh
devps
# Shows all active development servers and processes
```

### Example 5: Stop All Services
```zsh
devstop
# Stops Laravel, Nuxt, PHP, and Queue Workers
```

### Example 6: Docker Workflow
```zsh
# Start docker compose with logs
dcud && dclf

# Clean up everything
dclean
```

---

## 📁 Files

### `aliases.zsh`
Contains all command aliases for faster development (PHP, NPM, Docker, Navigation, Projects)

### `functions.zsh`
Contains advanced functions for:
- Project management and navigation
- Development server starters
- Service monitoring
- Utility functions

---

## ⚙️ Dependencies

Optional but recommended:
- **z** (Zoxide) - Fast navigation: https://github.com/ajeetdsouza/zoxide
- **VSCode** - For code editor integration
- **Docker** - For container management aliases
- **PHP/Composer** - For Laravel projects
- **Node.js/npm** - For Nuxt and frontend projects

---

## 🤝 Contributing

Contributions are welcome! To contribute:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## ℹ️ Notes

- These scripts are optimized for **Zsh** shell
- Project search paths can be customized in `functions.zsh`
- Docker aliases work best with Docker and Docker Compose installed
- Environment variables like `$devtools` should be set in your shell configuration
