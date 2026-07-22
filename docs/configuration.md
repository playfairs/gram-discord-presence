# Configuration

Gram Presence is highly configurable and allows you to customize almost every aspect of your Rich Presence.

Configuration is done through Gram's settings by modifying the extension's initialization options.

---

## Application ID

The `application_id` identifies the Discord application used for Rich Presence.

Unless you're using your own Discord application, you should leave this value unchanged.

```jsonc
"application_id": "1529209714779492443"
```

---

## Base Icons URL

The `base_icons_url` is the base location used when resolving language and editor icons.

```jsonc
"base_icons_url": "https://github.com/playfairs/gram-discord-presence/tree/main/assets/icons"
```

---

## State

The `state` field controls the primary status text shown in Discord.

You can use placeholders such as `{filename}` or `{line_number}`.

```jsonc
"state": "Editing {filename}:{line_number}"
```

---

## Details

The `details` field appears beneath the state.

Commonly it's used to display the current workspace or project.

```jsonc
"details": "Working in {workspace}"
```

---

## Large Image

The `large_image` determines which image is displayed as the primary Rich Presence icon.

Most configurations use the current language icon.

```jsonc
"large_image": "{base_icons_url}/{language:lo}.png"
```

---

## Large Text

The text shown when hovering over the large image.

```jsonc
"large_text": "{language:u}"
```

---

## Small Image

The secondary image displayed in Rich Presence.

Most users leave this as the Gram logo.

```jsonc
"small_image": "{base_icons_url}/gram.png"
```

---

## Small Text

Tooltip displayed when hovering over the small image.

```jsonc
"small_text": "Gram"
```

---

# Idle Configuration

Idle settings determine what happens when no activity has been detected.

### Timeout

Time before entering the idle state (seconds).

```jsonc
"timeout": 300
```

---

### Action

Available actions:

- `change_activity`
- `clear_activity`

---

### Example

```jsonc
"idle": {
    "timeout": 300,
    "action": "change_activity",

    "state": "Taking a break",
    "details": "In Gram",

    "large_image": "{base_icons_url}/gram.png",
    "large_text": "Gram",

    "small_image": "{base_icons_url}/idle.png",
    "small_text": "Idle"
}
```

---

# Workspace Rules

Rules allow Rich Presence to be disabled for specific directories.

Modes:

- `blacklist`
- `whitelist`

```jsonc
"rules": {
    "mode": "blacklist",
    "paths": [
        "/absolute/path"
    ]
}
```

---

# Git Integration

Enable or disable repository buttons in Discord.

```jsonc
"git_integration": true
```

---

# Git Host Overrides

Useful if your SSH configuration uses aliases instead of real hostnames.

Example:

```jsonc
"git_host_overrides": {
    "github-work": "github.com",
    "gitlab-home": "gitlab.com"
}
```

---

# Language Overrides

Override activity for individual programming languages.

Language names must be lowercase.

```jsonc
"languages": {
    "rust": {
        "state": "Building {filename}",
        "details": "Writing Rust",

        "large_image": "{base_icons_url}/rust.png",
        "large_text": "Rust",

        "small_image": "{base_icons_url}/gram.png",
        "small_text": "Gram"
    },

    "python": {
        "large_image": "{base_icons_url}/python.png",
        "large_text": "Python"
    }
}
```

If a language isn't specified, the global configuration is used.

---

# Complete Example

```jsonc
{
    "lsp": {
        "gram_presence": {
            "initialization_options": {
                "application_id": "1529209714779492443",

                "base_icons_url": "https://github.com/playfairs/gram-discord-presence/tree/main/assets/icons",

                "state": "Editing {filename}",
                "details": "Working in {workspace}",

                "large_image": "{base_icons_url}/{language:lo}.png",
                "large_text": "{language:u}",

                "small_image": "{base_icons_url}/gram.png",
                "small_text": "Gram",

                "idle": {
                    "timeout": 300,
                    "action": "change_activity",

                    "state": "Idle",
                    "details": "In Gram",

                    "large_image": "{base_icons_url}/gram.png",
                    "large_text": "Gram",

                    "small_image": "{base_icons_url}/idle.png",
                    "small_text": "Idle"
                },

                "rules": {
                    "mode": "blacklist",
                    "paths": [
                        "/absolute/path"
                    ]
                },

                "git_integration": true,

                "languages": {
                    "rust": {
                        "state": "Building {filename}",
                        "details": "Writing Rust"
                    }
                }
            }
        }
    }
}
```

---

# Resetting Values

Any configuration option can be set to `null` to inherit the default behavior, except for:

- `base_icons_url`
- `rules`
- `git_integration`

---

# Available Placeholders

The following placeholders may be used anywhere configuration values support them.

| Placeholder | Description |
|-------------|-------------|
| `{filename}` | Current file name |
| `{workspace}` | Current workspace |
| `{language}` | Current language |
| `{base_icons_url}` | Configured icon URL |
| `{relative_file_path}` | File path relative to workspace |
| `{folder_and_file}` | Parent folder and filename |
| `{directory_name}` | Parent directory |
| `{full_directory_name}` | Full directory path |
| `{line_number}` | Current cursor line |
| `{git_branch}` | Current Git branch |
| `{file_size}` | Current file size |

## Placeholder Modifiers

Modifiers may be appended to any placeholder except `{line_number}`.

| Modifier | Description |
|----------|-------------|
| `:u` | Capitalize first letter |
| `:lo` | Convert to lowercase |

Example:

```text
Editing {filename} in {directory_name:u}
```
