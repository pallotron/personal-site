# Hugo Site Exploration - Executive Summary

## Project: angelofailla.com (Personal Website)

**Type:** Static site generator (Hugo)
**Theme:** LoveIt + hugo-embed-pdf-shortcode
**Deployment:** Cloudflare Pages (auto-deploy on git push)
**Current User:** Technical (writes Markdown, uses Git)

---

## KEY FINDINGS

### 1. Content Structure Overview

The site contains **23 content files** organized into **5 content types**:

```text
Posts (10)          -> Dated hierarchy: /content/posts/YYYY/MM/DD/slug/
Articles (1)        -> Flat: /content/articles/slug/
Projects (6)        -> Flat: /content/projects/slug.md
Public Talks (4)    -> Flat: /content/public_talks/slug.md
Pages (2)           -> Root: /content/about/index.md, /content/cv.md
```

**Total Content:** ~23 markdown files + numerous co-located images

---

### 2. Frontmatter Inconsistency (Critical Issue)

The site uses **BOTH TOML and YAML formats** inconsistently:

**TOML (+++...+++):**

- Used in: About, CV, some old posts
- Format: `date = '2025-09-03T00:00:00Z'`

**YAML (---...---):**

- Used in: Most blog posts, articles, projects
- Format: `date: 2025-11-02T09:00:00+01:00`

**CMS Recommendation:** Standardize to YAML for simplicity

---

### 3. Frontmatter Fields by Type

| Content Type | Required Fields | Optional Fields |
|--------------|-----------------|-----------------|
| **Posts** | title, date | draft, tags, featured_image, images, author, description, categories |
| **Articles** | title, date, content | draft, tags, categories, author, description, featured_image, images |
| **Projects** | title | date, draft, (minimal) |
| **Talks** | title, date | draft, layout (set to "public_talks") |
| **Pages** | title | featured_image, images |

**Key Observations:**

- No strict schema validation
- Fields are optional/flexible
- `categories` field used but NOT configured as Hugo taxonomy
- `author` field auto-fills to "pallotron"

---

### 4. Configuration Management

**Main Config File:** `/hugo.toml` (270+ lines)

**Configured Features:**

- Theme setup
- Navigation menu (7 items)
- Social links (8 platforms)
- Analytics (Google Analytics)
- Comments (Disqus)
- Search (Lunr - client-side)
- Home page profile
- SEO/Open Graph

**Key Settings:**

```toml
baseURL = "https://angelofailla.com/"
theme = ["hugo-embed-pdf-shortcode", "LoveIt"]
enableEmoji = true
[[taxonomies]]
tag = 'tags'  # Only tags configured, NOT categories
```

---

### 5. Asset Management

**Image Strategy:**

- Images stored **alongside content** (colocated)
- Posts with complex assets have organized subdirectories:
  - `/images/` for galleries
  - `/screenshots/` for documentation
  - `/videos/` for embedded media

**Large Assets:**

- Some images 2-5 MB (acceptable for static site)
- Examples: celtic_knot_report (100+ images), lel25 (60+ images)

---

### 6. Theme & Customization

**Theme Stack:**

1. **LoveIt** (primary) - Clean, responsive blog theme
2. **hugo-embed-pdf-shortcode** (secondary) - For PDF embedding
3. **Modules:** hugo-shortcode-gallery, hugo-video

**Custom Overrides:**

- `/layouts/` directory with 12 custom template files
- Section-specific layouts (posts, articles, public_talks)
- Custom shortcodes (YouTube, Strava, PDF, image, rawhtml)

---

## CMS DESIGN REQUIREMENTS

### What Needs to Happen

1. **Hide Complexity**
   - File paths (YYYY/MM/DD/slug pattern)
   - TOML/YAML format choice
   - Markdown syntax details
   - Git operations
   - Hugo build process

2. **Provide Forms For**
   - Content creation by type
   - Metadata entry (date, tags, images)
   - Image uploads & colocation
   - Draft/publish workflow

3. **Generate Automatically**
   - File paths from date + slug
   - Frontmatter (standardize to YAML)
   - Image filenames & organization

---

### MVP Feature Set

#### Phase 1 - Blog Posts

- Create/edit/delete posts
- WYSIWYG markdown editor
- Image upload (multiple)
- Date picker
- Tags (multi-select)
- Featured image selection
- Draft/publish toggle

#### Phase 2 - Other Content Types

- Articles editor
- Projects editor
- Public talks editor
- Page editor

#### Phase 3 - Advanced

- Content preview
- Scheduled publishing
- Menu management
- Config editing (safe parameters)
- Revision history

---

## TECHNICAL STACK RECOMMENDATIONS

### Frontend

- **React** or **Vue.js** (React recommended for complexity)
- **CodeMirror** (markdown editor with preview)
- **Tailwind CSS** (styling)
- **React Hook Form** + **Zod** (validation)

### Backend

- **Node.js + TypeScript** (native fit with Hugo ecosystem)
- **Express** or **Next.js API routes**
- **Sharp** (image optimization)
- **Simple-git** or **node-git** (git operations)

### File Management

- Direct filesystem access (since running locally with Hugo)
- YAML parser for frontmatter generation
- Path builder for automatic URL/path generation

### Preview & Build

- Hugo binary integration (call `hugo` directly)
- Local HTML rendering before publish
- Git-based versioning (commits on save/publish)

---

## CRITICAL DECISIONS

1. **Standardize Frontmatter to YAML**
   - Convert existing TOML files
   - Hide format from users
   - Cleaner API

2. **Simplify Taxonomies**
   - Remove `categories` OR add it as proper taxonomy
   - Keep only `tags` for MVP
   - Pre-populate from existing tags

3. **Auto-generate Paths**
   - Post: `/posts/{YYYY}/{MM}/{DD}/{slug}/`
   - Other: `/{type}/{slug}/`
   - Slug auto-generated from title, user can override

4. **Image Management**
   - Single "Featured Image" field
   - Multiple "Gallery Images" field
   - Auto-organize into `/images/` subdirs
   - Generate both fields in frontmatter

---

## RISKS & MITIGATION

| Risk | Impact | Mitigation |
|------|--------|-----------|
| TOML/YAML inconsistency | Confusion, errors | Standardize to YAML on import |
| Categories inactive | Unused field in forms | Remove or configure as taxonomy |
| Complex asset structure | Path generation errors | Auto-generate, validate paths |
| No content preview | Publish errors | Integrate Hugo preview build |
| Git required | Non-technical barrier | Automate git operations behind UI |
| Date-hierarchical posts | Complex UX | Auto-generate path from picker |

---

## IMPLEMENTATION TIMELINE ESTIMATE

### MVP (4-6 weeks)

- Blog post CRUD
- Markdown editor
- Basic metadata
- Image upload
- Draft/publish

### Phase 2 (2-3 weeks)

- Multi-type support
- Tags management
- Featured images
- Gallery images

### Phase 3 (3-4 weeks)

- Menu management
- Config editing
- Preview system
- Revision history

**Total: 8-13 weeks** for full-featured CMS

---

## AUDIENCE

**Current User:** Technical (Angelo Failla)

- Creates markdown files locally
- Understands git/frontmatter
- Manages own file organization

**Proposed User:** Non-technical content creator

- Needs simple form-based interface
- Cannot understand paths/frontmatter
- Needs visual feedback (preview)
- Cannot manage git

---

## NEXT STEPS

1. **Define MVP scope** (which content types first?)
2. **Choose frontend framework** (React vs Vue)
3. **Design database schema** (content types, fields)
4. **Build image handling system** (upload, optimize, colocation)
5. **Implement frontmatter parser** (YAML only)
6. **Create admin UI** (forms by content type)
7. **Integrate Hugo build** (preview + auto-publish)
8. **Test with real content** (use existing 23 files)

---

## APPENDIX: File Locations

**Main config:** `/Users/pallotron/code/site/hugo.toml`
**Content:** `/Users/pallotron/code/site/content/`
**Layouts:** `/Users/pallotron/code/site/layouts/`
**Theme:** `/Users/pallotron/code/site/themes/LoveIt/`

**Git repo:** <https://github.com/pallotron/site>
**Deployed at:** <https://angelofailla.com/>
