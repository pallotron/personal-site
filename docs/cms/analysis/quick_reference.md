# Hugo Site Structure - Quick Reference Guide

## File Paths Summary

| Item | Path | Pattern |
|------|------|---------|
| Config | `/hugo.toml` | Single main config |
| Posts | `/content/posts/2025/MM/DD/slug/index.md` | Date-hierarchical |
| Articles | `/content/articles/slug/index.md` | Flat |
| Projects | `/content/projects/slug.md` | Flat files |
| Public Talks | `/content/public_talks/YYYY-event.md` | Flat files |
| About | `/content/about/index.md` | Single index |
| CV | `/content/cv.md` | Single file |
| Theme | `/themes/LoveIt/` | Git submodule |
| Custom Layouts | `/layouts/` | Overrides theme |
| Static Assets | `/static/` | PDFs, favicons, etc |

---

## Frontmatter Fields Reference

### Minimal Set (All Content)

```yaml
---
title: "Required"
---
```

### Standard Set (Posts)

```yaml
---
title: "Post Title"
date: 2025-11-02T09:00:00+01:00
draft: false
tags: ["tag1", "tag2"]
featured_image: "image.jpg"
---
```

### Full Set (Articles)

```yaml
---
title: "Article Title"
date: 2025-10-04T09:00:00+01:00
draft: false
author: "Angelo Failla"
description: "Article description"
categories: ["category"]
tags: ["tag1", "tag2"]
featured_image: "image.jpg"
images: ["image1.jpg", "image2.jpg"]
---
```

### Quick Format Check

```text
TOML uses:     +++...+++
YAML uses:     ---...---
Default arch:  YAML
Inconsistency: Yes, both used
Recommendation: Standardize to YAML
```

---

## Content Statistics

| Type | Count | Location |
|------|-------|----------|
| Blog Posts | 10 | posts/2025/[03,04,06,08,09,10,11] |
| Articles | 1 | articles/observations_outside_meta |
| Projects | 6 | projects/*.md |
| Public Talks | 4 | public_talks/*.md |
| Static Pages | 2 | about/, cv.md |
| **Total** | **23 files** | **content/** |

---

## Tag Usage Analysis

**Sample tags from posts:**

```text
Common: hugo, career, work, meta, facebook, cycling, tech, python
Infrastructure: linux, networking, dhcp, golang, ci-cd
Domain-specific: photography, randonneuring, audax
Content-type: personal, learning, ui, cli
```

**Pattern:** Lowercase, single-word or hyphenated, no limit enforced

---

## Configuration Highlights

### Enabled Features

- Emoji support
- Disqus comments
- Google Analytics
- Lunr search (client-side)
- Table of Contents
- Syntax highlighting
- Social menu (8 platforms)
- RSS feeds

### Disabled/Absent

- Algolia search
- Categories as taxonomy
- Multiple languages (en only)
- Portfolio/Gallery plugins

### Output Formats

```text
Home:     HTML, RSS, JSON
Posts:    HTML, RSS
Tags:     HTML
```

---

## Theme Customizations

### Custom Shortcodes

1. `{{< youtube id="..." >}}`
2. `{{< embed-pdf url="..." >}}`
3. `{{< strava-activity ... >}}`
4. `{{< image ... >}}`
5. `{{< rawhtml >}} ... {{< /rawhtml >}}`
6. `{{< gallery ... >}}`

### Custom Layouts

- Posts section (/posts/)
- Articles (list + single)
- Public talks (section)
- Default single pages

### Modules

- hugo-shortcode-gallery
- hugo-video

---

## Content Creation Workflow (Current)

```text
1. User writes Markdown locally
2. Adds frontmatter (TOML or YAML)
3. Places file in appropriate directory
4. Commits to Git
5. Pushes to GitHub
6. Cloudflare detects push
7. Runs: hugo build
8. Deploys to Cloudflare Pages
9. Live on https://angelofailla.com/
```

---

## CMS Abstraction Model

### What CMS Needs to Hide

- File paths and hierarchies
- Frontmatter format (TOML vs YAML)
- Markdown syntax details
- Git operations
- Hugo build process
- Static file management

### What CMS Needs to Manage

- Content creation forms (by type)
- Image uploads and optimization
- Publishing workflow (draft → live)
- Metadata management (tags, dates)
- Preview/preview generation
- Automatic path generation

### What CMS Should NOT Touch

- Theme files
- Layout templates
- Configuration (beyond simple params)
- Static assets (favicons, PDFs)
- Hugo module management

---

## Menu Configuration

**Current Menu Items (7 items):**

1. About me (weight: 1)
2. Resume (weight: 1)
3. Public talks (weight: 2)
4. Projects (weight: 3)
5. Articles (weight: 4)
6. Posts (weight: 4)
7. Tags (weight: 5)
8. RSS (weight: 6)

**Icons used:** Emojis (👋, 📝, 🎤, ⚙, 🗓️, 🏷️, RSS image)

---

## Build Environment

**Requirements:**

- Hugo >= 0.128.0
- Go modules
- Ruby (for HTMLProofer testing)
- Git

**Build Command:** `hugo` or `make build`
**Deployment:** Cloudflare Pages (auto-triggered on git push)

---

## CMS Implementation Checklist

### Phase 1: Core

- [ ] Post CRUD operations
- [ ] Markdown editor with preview
- [ ] Image upload + colocation
- [ ] YAML frontmatter generation
- [ ] Auto path generation (YYYY/MM/DD/slug)
- [ ] Draft/publish toggle
- [ ] Date/time picker

### Phase 2: Enhance

- [ ] Article editor
- [ ] Project editor
- [ ] Public talks editor
- [ ] Page editor
- [ ] Tags autocomplete
- [ ] Featured image management
- [ ] Images gallery

### Phase 3: Advanced

- [ ] Menu editor (TOML update)
- [ ] Config editor (safe params only)
- [ ] Search functionality
- [ ] Revision history (git)
- [ ] Scheduled publishing
- [ ] Preview deployment
- [ ] Analytics dashboard

---

## Known Issues to Address

1. **TOML/YAML mix** - Needs standardization
2. **Categories unconfigured** - Either remove or activate
3. **No slug validation** - Potential for duplicate paths
4. **Manual asset management** - Images need structure
5. **No content preview** - Can't see final rendering before publish
6. **No version control UI** - Users need to understand git
