# Hugo-Based Website Comprehensive Analysis

## angelofailla.com

---

## 1. OVERALL DIRECTORY STRUCTURE

```text
/Users/pallotron/code/site/
├── .github/                    # GitHub Actions CI/CD workflows
├── .gitignore                  # Git ignore rules
├── .jj/                        # Jujutsu VCS configuration
├── archetypes/                 # Content templates/blueprints
├── assets/                     # Asset processing directory
├── content/                    # ALL WEBSITE CONTENT (primary focus)
├── data/                       # Data files for templates
├── i18n/                       # Internationalization files
├── layouts/                    # Custom HTML templates
├── public/                     # Generated static output
├── resources/                  # Generated resource cache
├── static/                     # Static assets (CSS, images, PDFs, etc.)
├── themes/                     # Hugo themes
├── Gemfile/Gemfile.lock        # Ruby dependencies (HTMLProofer)
├── go.mod/go.sum              # Go module dependencies
├── hugo.toml                  # MAIN HUGO CONFIGURATION FILE
├── Makefile                   # Build automation
└── README.md
```

---

## 2. CONTENT DIRECTORY ORGANIZATION

### Directory Structure

```text
content/
├── about/                          # About page section
│   ├── index.md                   # Main about page
│   └── AngeloLEL.jpeg             # Profile image
├── articles/                       # Long-form articles (different from posts)
│   └── observations_outside_meta/
│       └── index.md               # Article with index.md pattern
├── posts/                          # Blog posts (organized by date)
│   └── 2025/
│       ├── 03/20/playing_with_hugo/
│       │   ├── index.md
│       │   ├── cloudfare.png
│       │   └── hugo.png
│       ├── 04/04/badge_post/
│       ├── 06/04/celtic_knot_report/
│       │   ├── images/
│       │   ├── videos/
│       │   └── index.md
│       ├── 08/10/lel25/
│       ├── 09/02/new-job/
│       ├── 10/04/observations_from_outside_meta/
│       ├── 10/16/testing-with-linux-namespaces/
│       ├── 11/02/expenses_analyzer/
│       │   ├── screenshots/
│       │   └── index.md
│       └── [more dates...]
├── projects/                       # Project pages
│   ├── projects.md               # Projects index/list page
│   ├── dhcplb.md                 # Individual project
│   ├── expenses_analyzer.md
│   ├── fbender.md
│   ├── fbtftp.md
│   ├── pvmlab.md
│   ├── pvmlab.png               # Project image
│   └── yubiswitch.md
├── public_talks/                   # Conference talks
│   ├── _index.md                 # Section index
│   ├── 2014-PyconIreland-Python@FB.md
│   ├── 2015-SRECON-EMEA-KEA.md
│   └── 2016-EuroPython-fbtftp.md
└── cv.md                           # Resume page

TOTAL: 22 markdown files
```

### Content Organization Patterns

**By Content Type:**

- **Posts**: 10 blog posts (dated YYYY/MM/DD/slug/index.md)
- **Articles**: 1 long-form article (observations_outside_meta)
- **Projects**: 6 project pages + 1 index page
- **Public Talks**: 4 conference talks + 1 section index
- **Pages**: About, CV (standalone)
- **Index Pages**: 3 (_index.md or section listing pages)

**File Naming Conventions:**

- Blog posts: `YYYY/MM/DD/slug-name/index.md` (modern Hugo nested structure)
- Projects: `project-name.md` (flat in projects/ directory)
- Public talks: `YYYY-event-name.md` (flat in public_talks/ directory)
- Index pages: `_index.md` or `index.md` at section roots

---

## 3. FRONTMATTER FIELDS & PATTERNS

### Two Frontmatter Formats Used

#### FORMAT A: TOML (using +++ delimiters)

Used in: About, CV, some posts

```toml
+++
date = '2025-09-03T00:00:00Z'
draft = false
title = '👋 About me'
featured_image = "AngeloLEL.jpeg"
images = ["AngeloLEL.jpeg"]
+++
```

**TOML Fields Observed:**

- `date` - Creation/publish date (ISO 8601 format)
- `draft` - Boolean (true/false) for unpublished content
- `title` - Page/post title
- `featured_image` - Single featured image filename
- `images` - Array of image filenames

#### FORMAT B: YAML (using --- delimiters)

Used in: Most blog posts, articles, projects, public talks

```yaml
---
title: "Post Title"
date: 2025-11-02
draft: false
tags:
  - tag1
  - tag2
featured_image: "image.jpg"
images: ["image.jpg"]
author: "Angelo Failla"
description: "Post description"
categories: ["category-name"]
---
```

**YAML Fields Observed:**

| Field | Type | Required | Example | Notes |
|-------|------|----------|---------|-------|
| `title` | String | Yes | "Post Title" | Can include emojis |
| `date` | DateTime | Yes | 2025-11-02 or 2025-11-02T09:00:00+01:00 | Multiple date formats used |
| `draft` | Boolean | No | false | Default: false |
| `tags` | Array | No | ["tag1", "tag2"] | Can have 10+ tags; array format |
| `featured_image` | String | No | "image.jpg" | Single image filename (relative) |
| `images` | Array | No | ["image1.jpg", "image2.jpg"] | Array of images |
| `author` | String | No | "Angelo Failla" | Optional metadata |
| `description` | String | No | "Brief description" | SEO description |
| `categories` | Array | No | ["career"] | Content categorization |
| `layout` | String | No | "public_talks" | Custom layout selection |

**Frontmatter Format Inconsistencies:**

- The site uses BOTH TOML (+++...+++) AND YAML (---...---) formats
- Even within the same section (posts), you'll find both formats
- No strict convention enforced (archetype uses YAML, but users choose)

### Actual Field Usage by Content Type

**Posts (Blog):**

```yaml
title, date, draft, tags, featured_image, images, (author), (description), (categories)
```

Example: `/content/posts/2025/11/02/expenses_analyzer/index.md`

- 15+ tags in array format
- featured_image + images array
- Multiple date format variations

**Articles:**

```yaml
title, date, draft, tags, featured_image, images, author, description, categories
```

More metadata-rich than posts. Example: `observations_outside_meta`

**Projects:**

```yaml or +++
title, date, draft
```

Minimal frontmatter - projects are content-focused, no tags or categories.

**Public Talks:**

```yaml
date, draft, title
```

Very minimal. Some include:

```yaml
layout: public_talks  # Custom layout override
```

**Pages (About, CV):**

```toml/yaml
date, draft, title, featured_image, (images)
```

Simple structure, sometimes with images.

---

## 4. THEMES & LAYOUTS

### Theme Stack

**Theme(s) used:** `themes/LoveIt` (primary) + `hugo-embed-pdf-shortcode` (secondary)

From `hugo.toml`:

```toml
theme = ["hugo-embed-pdf-shortcode", "LoveIt"]
```

**Theme Details:**

- **Name:** LoveIt
- **GitHub:** <https://github.com/dillonzq/LoveIt>
- **Min Hugo Version:** 0.128.0
- **License:** MIT
- **Features:** Blog, clean design, responsive, dark mode, pagination, social menu, syntax highlighting, SEO optimized

### Custom Layouts Override Theme

The site has **custom layouts** that override theme defaults:

```text
layouts/
├── _default/
│   ├── single.html          # Default single page template
│   └── summary.html         # Content summary template
├── articles/
│   ├── list.html            # Article listing page
│   └── single.html          # Individual article template
├── posts/
│   ├── section.html         # Posts section/listing page
│   └── single.html          # Individual post template
├── public_talks/
│   └── section.html         # Public talks section template
├── partials/
│   ├── head/link.html       # Custom head links
│   └── plugin/img.html      # Custom image rendering
└── shortcodes/
    ├── image.html           # Custom image shortcode
    ├── rawhtml.html         # Raw HTML shortcode
    └── strava-activity.html # Strava activity embed shortcode
```

**Custom Features:**

1. **Shortcodes** for special embeds (Strava activities, YouTube, PDFs)
2. **Custom image handling** with plugin/img.html
3. **Section-specific layouts** for different content types
4. **Raw HTML shortcode** for embedded content

### Hugo Modules

```toml
[[module.imports]]
path = "github.com/mfg92/hugo-shortcode-gallery"
[[module.imports]]
path = "github.com/martignoni/hugo-video"
```

**Additional Modules:**

- `hugo-shortcode-gallery` - Gallery shortcode for image collections
- `hugo-video` - Video embedding support

---

## 5. HUGO CONFIGURATION STRUCTURE

### Main Config File: `hugo.toml`

**Key Configuration Sections:**

#### A. Site Metadata

```toml
baseURL = "https://angelofailla.com/"
title = "angelofailla.com"
languageCode = "en"
languageName = "English"
enableEmoji = true
timeout = "120s"
```

#### B. Theme Configuration

```toml
theme = ["hugo-embed-pdf-shortcode", "LoveIt"]
```

#### C. Output Formats

```toml
[outputs]
home = ['html', 'rss', 'json']
section = ['html', 'rss']
taxonomy = ['html']
term = ['html']
```

#### D. Content Management

```toml
[taxonomies]
tag = 'tags'
# No categories configured - categories in frontmatter are not auto-indexed
```

**NOTE:** Only `tags` taxonomy is configured. The `categories` field in some posts is used but NOT configured as a taxonomy.

#### E. Page Defaults

```toml
[params.page]
author = "pallotron"

[params.page.toc]
enable = true
keepStatic = false
auto = true  # Automatically collapse TOC

[params.page.comment]
enable = true
[params.page.comment.disqus]
enable = true
shortname = "pallotron"
```

#### F. Home Page Configuration

```toml
[params.home.profile]
enable = true
gravatarEmail = "pallotron@gmail.com"
title = "Welcome to my homepage..."
subtitle = "More info about me in the <a href='/about/'>About me page</a>..."
social = true

[params.home.posts]
enable = true
paginate = 6  # 6 posts per page on homepage
```

#### G. Navigation Menu

```toml
[[menu.main]]
weight = 1
identifier = "about"
pre = "👋"
name = "About me"
url = "/about/"

[[menu.main]]
weight = 2
identifier = "Public talks"
name = "Public talks"
url = "/public_talks/"

[[menu.main]]
weight = 3
identifier = "projects"
name = "Projects"
url = "/projects/"

[[menu.main]]
weight = 4
identifier = "articles"
name = "📝 Articles"
url = "/articles/"

[[menu.main]]
weight = 4
identifier = "posts"
pre = "🗓️"
name = "Posts"
url = "/posts/"

[[menu.main]]
weight = 5
identifier = "tags"
name = "Tags"
url = "/tags/"

[[menu.main]]
weight = 6
identifier = "rss"
name = "RSS"
url = "/index.xml"
```

#### H. Search Configuration

```toml
[params.search]
enable = true
type = "lunr"  # Client-side search (not Algolia)
contentLength = 4000
maxResultLength = 10
snippetLength = 30
```

#### I. Analytics & Comments

```toml
[services.disqus]
shortname = 'pallotron'

[params.analytics.google]
id = "G-Q3TN4Z8MMZ"  # Google Analytics
```

#### J. Social Links

```toml
[params.social]
GitHub = "pallotron"
Linkedin = "pallotron"
X = "pallotron"
Instagram = "pallotron"
Facebook = "pallotron"
Flickr = "pallotron"
Strava = "25038229"
Threads = "pallotron"
Email = "pallotron@gmail.com"
```

#### K. Markup Processing

```toml
[markup]
[markup.highlight]
noClasses = false  # Use CSS classes for syntax highlighting
```

---

## 6. STATIC ASSETS

**Location:** `/static/`

**Files:**

- `angelo_failla_resume.pdf` - Resume PDF
- `favicon.svg`, `favicon.ico`, `favicon-96x96.png` - Favicons
- `apple-touch-icon.png` - iOS home screen icon
- `web-app-manifest-*.png` - PWA icons
- `site.webmanifest` - PWA manifest
- `safari-pinned-tab.svg` - Safari tab icon
- `rss-feeds.webp` - RSS feed image
- `public_talk*.jpg` - Public talks hero images
- `ads.txt` - Advertising protocol file
- `/slides/` directory - Conference presentation PDFs

---

## SUMMARY: KEY INSIGHTS FOR CMS DESIGN

### Content Organization Principles

1. **Posts are dated/hierarchical**: `YYYY/MM/DD/slug/`
2. **Other content is flat**: Projects, talks, pages at section root
3. **Mixed file/folder patterns**: Some posts use `index.md` in folders (for colocated assets), others are single files
4. **Asset colocation**: Images stored next to content (in post folders or same directory)

### Frontmatter Flexibility Issues

- **Format inconsistency**: Both TOML and YAML used; no single standard
- **Optional fields**: Many fields are optional, usage varies
- **Inactive taxonomy**: Categories field exists but isn't configured as Hugo taxonomy
- **Custom field usage**: All tags are ad-hoc; no predefined tag system

### Content Types

1. **Posts** (dated blog articles, 10 total)
2. **Articles** (long-form content, 1 total)
3. **Projects** (portfolio items, 6-7 total)
4. **Public Talks** (conference presentations, 4 total)
5. **Pages** (static: About, CV)

### User Demographics

- **Technical user**: All content hand-written in Markdown
- **Single author**: All content by Angelo Failla
- **Version controlled**: Entire site in Git, deployed via Cloudflare
- **Non-technical user challenges**: Would struggle with date hierarchies, TOML/YAML choice, frontmatter field selection

### CMS Requirements Based on Structure

✓ Support for multiple content types
✓ Flexible frontmatter field configuration
✓ Rich media handling (co-located images/assets)
✓ Tags/taxonomy management
✓ Draft/publish workflow
✓ Date-based post organization
✓ Markdown + Rich editor hybrid
✓ Menu management
✓ Social link configuration
