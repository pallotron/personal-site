# Hugo Site - Actual File Structure Examples

## Directory Tree (Complete)

```text
/Users/pallotron/code/site/
│
├── .github/
│   └── workflows/              # GitHub Actions CI/CD
│
├── archetypes/
│   └── default.md              # Content template blueprint
│       ├── date: '{{ .Date }}'
│       ├── draft: true
│       └── title: '{{ replace .File.ContentBaseName "_" " " | title }}'
│
├── assets/                     # Processed assets
│
├── content/                    # PRIMARY CONTENT DIRECTORY
│   │
│   ├── about/                  # About page section
│   │   ├── index.md
│   │   └── AngeloLEL.jpeg      # Co-located image
│   │
│   ├── articles/               # Long-form articles (flat)
│   │   └── observations_outside_meta/
│   │       ├── index.md        # 12,000+ word article
│   │       └── meta.jpg        # Feature image
│   │
│   ├── posts/                  # Blog posts (date-hierarchical)
│   │   └── 2025/
│   │       ├── 03/20/          # March 20, 2025
│   │       │   └── playing_with_hugo/
│   │       │       ├── index.md
│   │       │       ├── hugo.png
│   │       │       └── cloudfare.png
│   │       ├── 04/04/          # April 4, 2025
│   │       │   └── badge_post/
│   │       │       ├── index.md
│   │       │       └── badge.jpg
│   │       ├── 06/04/          # June 4, 2025 (1000km ride report)
│   │       │   └── celtic_knot_report/
│   │       │       ├── index.md       # 8,000+ words
│   │       │       ├── route.jpg
│   │       │       ├── images/        # Organized subdirs
│   │       │       │   ├── chilling_out/
│   │       │       │   ├── start/
│   │       │       │   ├── 2nd_day/
│   │       │       │   ├── 3rd_day/
│   │       │       │   └── to_loop_head/
│   │       │       └── videos/        # Video directory
│   │       │
│   │       ├── 08/10/lel25/          # August 10
│   │       │   └── ... similar structure ...
│   │       │       ├── images/ (multiple subdirectories)
│   │       │       └── videos/
│   │       │
│   │       ├── 09/02/new-job/        # September 2
│   │       ├── 10/04/observations_from_outside_meta/
│   │       ├── 10/16/testing-with-linux-namespaces/
│   │       │   ├── index.md          # 5,000+ words with code
│   │       │   └── linux-namespaces.png (2.4MB diagram)
│   │       │
│   │       └── 11/02/expenses_analyzer/
│   │           ├── index.md
│   │           ├── logo.jpg
│   │           └── screenshots/       # Project docs
│   │               ├── import-001-start.jpg
│   │               ├── import-002-browse.jpg
│   │               ├── import-003-csv-preview.jpg
│   │               ├── categorize-merchants.jpg
│   │               ├── summary.png
│   │               ├── summary-monthly.png
│   │               └── transactions.png
│   │
│   ├── projects/                # Project portfolio (flat files)
│   │   ├── projects.md          # Index page (links to all projects)
│   │   ├── dhcplb.md            # DHCP Load Balancer
│   │   ├── expenses_analyzer.md # Personal project
│   │   ├── fbender.md           # Load testing tool
│   │   ├── fbtftp.md            # TFTP server
│   │   ├── pvmlab.md            # Virtual provisioning lab
│   │   ├── pvmlab.png           # Co-located image
│   │   └── yubiswitch.md        # macOS Yubikey app
│   │
│   ├── public_talks/             # Conference presentations (flat)
│   │   ├── _index.md            # Section listing page
│   │   ├── 2014-PyconIreland-Python@FB.md
│   │   ├── 2015-SRECON-EMEA-KEA.md
│   │   └── 2016-EuroPython-fbtftp.md
│   │
│   ├── cv.md                     # Resume page
│   │
│   └── (Root content files)
│
├── data/                         # Data files for templates
│
├── i18n/                         # Internationalization (unused)
│
├── layouts/                      # Custom template overrides
│   ├── _default/
│   │   ├── single.html          # Default single page
│   │   └── summary.html         # Summary/list template
│   │
│   ├── articles/
│   │   ├── list.html            # Article archive
│   │   └── single.html          # Individual article
│   │
│   ├── posts/
│   │   ├── section.html         # Posts listing/archive
│   │   └── single.html          # Individual post
│   │
│   ├── public_talks/
│   │   └── section.html         # Talks listing
│   │
│   ├── partials/
│   │   ├── head/
│   │   │   └── link.html        # Custom head links
│   │   └── plugin/
│   │       └── img.html         # Custom image handling
│   │
│   └── shortcodes/              # Custom shortcodes
│       ├── image.html
│       ├── rawhtml.html         # For embedded HTML
│       └── strava-activity.html # Strava widgets
│
├── public/                       # Generated output (ignore in git)
│   ├── index.html
│   ├── posts/
│   ├── projects/
│   ├── articles/
│   └── ... (generated by hugo build)
│
├── resources/                    # Hugo cache (ignore in git)
│
├── static/                       # Static assets (served as-is)
│   ├── favicon.svg
│   ├── favicon.ico
│   ├── favicon-96x96.png
│   ├── apple-touch-icon.png
│   ├── web-app-manifest-192x192.png
│   ├── web-app-manifest-512x512.png
│   ├── safari-pinned-tab.svg
│   ├── site.webmanifest         # PWA config
│   ├── rss-feeds.webp
│   ├── ads.txt
│   ├── angelo_failla_resume.pdf
│   ├── public_talk.jpg
│   ├── public_talk_2.jpg
│   ├── .DS_Store
│   └── slides/                  # Conference presentation PDFs
│       ├── srecon15europe_slides_failla.pdf
│       └── ...
│
├── themes/                       # Theme and modules
│   ├── LoveIt/                  # Primary theme (git submodule)
│   │   ├── theme.toml
│   │   ├── layouts/             # Theme templates
│   │   ├── assets/
│   │   ├── i18n/               # 20+ language files
│   │   ├── exampleSite/
│   │   └── ... (large theme dir)
│   │
│   └── hugo-embed-pdf-shortcode/ # Secondary theme/module
│       └── ... (PDF embedding support)
│
├── hugo.toml                     # MAIN CONFIGURATION
├── .gitignore
├── .gitmodules
├── Gemfile / Gemfile.lock        # Ruby dependencies (HTMLProofer)
├── go.mod / go.sum              # Go module dependencies
├── Makefile                     # Build automation
└── README.md
```

---

## Example: Blog Post Directory

### Minimal Blog Post (Simple)

```text
posts/2025/03/20/playing_with_hugo/
├── index.md
├── hugo.png
└── cloudfare.png
```

#### File: index.md

```markdown
---
date = '2025-03-20T17:45:16Z'
draft = false
title = 'Playing with hugo'
tags = ["hugo", "gohugo", "wordpress", "static-site-generator", 
        "cloudflare", "ci-cd", "github", "tech"]
featured_image = 'hugo.png'
+++

I have decided to retire my old wordpress blog...

[Content continues...]

![Cloudflare Setup](cloudfare.png)
```

### Complex Blog Post (With Assets)

```text
posts/2025/06/04/celtic_knot_report/
├── index.md                    (8,000+ words)
├── route.jpg                   (featured image)
├── images/
│   ├── chilling_out/           (10-15 photos)
│   ├── start/                  (multiple photos)
│   ├── 2nd_day/                (photo gallery)
│   ├── 3rd_day/
│   └── to_loop_head/
└── videos/                     (embedded video files)
```

#### File: index.md (excerpt)

```yaml
---
date: "2025-06-04T10:08:35+01:00"
draft: false
title: "Celtic Knot 1000 Ride Report"
tags: ["cycling", "audax", "randonneuring", "ultra-cycling", 
       "endurance-cycling", "ride-report", "celtic-knot", 
       "ireland", "mason-cycles", "bike-packing"]
featured_image: "route.jpg"
images: ["route.jpg"]
---

This is a report of my successful Celtic Knot brevet.

## Day 1: 362km

The first day goes through part of the Wild Atlantic Way...

{{< gallery match="images/chilling_out/*" sortOrder="desc" 
  rowHeight="150" margins="5" thumbnailResizeOptions="600x600 q90 Lanczos" 
  showExif=true previewType="blur" embedPreview=true loadJQuery=true >}}
```

---

## Example: Article File

```text
articles/observations_outside_meta/
├── index.md                    (12,000+ words, evolving)
└── meta.jpg                    (featured image)
```

### Article File Content

```yaml
---
title: "Observations from Outside Meta"
date: 2025-10-04T09:00:00+01:00
draft: false
author: "Angelo Failla"
description: "My observations after leaving Meta after 14 years"
categories: ["career"]
tags: ["meta", "facebook", "career", "work"]
featured_image: "meta.jpg"
images: ["meta.jpg"]
---

This article is a collection of observations from the point of view of an
ex-Meta (formerly Facebook) engineer of 14 years...

**It will evolve over time as I work in different places and observe how
things are done differently.**

## The good

- **Fast compilation time**: ...
- **Open Source Ecosystem**: ...
```

---

## Example: Project File

```text
projects/
├── fbtftp.md
├── expenses_analyzer.md
└── ...
```

### Project File Content

```yaml
---
title: "FBTFTP"
date: "2025-09-02T08:04:26+01:00"
draft: false
---

Dynamic TFTP server written in Python3 that was used in Meta/Facebook 
datacenters (now replaced).

🏢 Presented at [Euro Python 2016 - Bilbao, Spain](...)
🌎 [Conference official website](...)
📊 [Slides](/slides/srecon15europe_slides_failla.pdf)
⌨️ Code: <https://github.com/facebookarchive/fbtftp>
🎥 Video:
{{< youtube id="1pndeS8FIS8" >}}
```

---

## Configuration File Structure

### Hugo Configuration

```toml
# Site basics
baseURL = "https://angelofailla.com/"
title = "angelofailla.com"
languageCode = "en"
enableEmoji = true

# Themes
theme = ["hugo-embed-pdf-shortcode", "LoveIt"]

# Module imports
[[module.imports]]
path = "github.com/mfg92/hugo-shortcode-gallery"

# Parameters
[params]
defaultTheme = "auto"
dateFormat = "Monday, 02-Jan-06 15:04:05 MST"

[params.home.profile]
enable = true
gravatarEmail = "pallotron@gmail.com"
title = "Welcome to my homepage, my name is Angelo Failla."

[params.social]
GitHub = "pallotron"
Linkedin = "pallotron"
X = "pallotron"
Email = "pallotron@gmail.com"

# Navigation menu
[[menu.main]]
weight = 1
identifier = "about"
pre = "👋"
name = "About me"
url = "/about/"

[[menu.main]]
weight = 3
identifier = "projects"
name = "Projects"
url = "/projects/"

# Taxonomies
[taxonomies]
tag = 'tags'
```

---

## Content Statistics by Type

### Posts (10 total)

- Dates span: March - November 2025
- Average length: 2,000-5,000 words (except cycle reports: 8,000+)
- Average images: 2-3 (minimal to 20+ for ride reports)
- All in YAML format
- Tags: 5-15 per post

### Articles (1 total)

- "Observations from Outside Meta"
- 12,000+ words
- 1 featured image
- Rich metadata (author, description, categories, tags)
- Marked as evolving/living document

### Projects (6 total)

- Simple: title + description
- Links to external repos/presentations
- Uses emoji bullets for formatting
- Minimal frontmatter (title, date, draft)
- No tags or categories

### Public Talks (4 total)

- Simple structure: title + date + custom layout
- Content: Event name, location, presentation links, video embed
- Uses shortcodes for YouTube embeds
- Minimal metadata

### Static Pages (2 total)

- About: Profile image, bio (2 sections)
- CV: PDF embed, GitHub link, LaTeX-based resume

---

## Shortcode Usage Examples

### YouTube Embed

```markdown
{{< youtube id="1pndeS8FIS8" >}}
```

### PDF Embed

```markdown
{{< embed-pdf url="/angelo_failla_resume.pdf" >}}
```

### Image Gallery

```markdown
{{< gallery match="images/chilling_out/*" sortOrder="desc" rowHeight="150" >}}
```

### Strava Activity

```markdown
{{< strava-activity id="..." >}}
```

### Raw HTML

```markdown
{{< rawhtml >}}
<a href="https://github.com/pallotron/cv">
  <i class="fab fa-github"></i> See source code
</a>
{{< /rawhtml >}}
```
