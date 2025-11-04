# CMS Design Recommendations for Non-Technical Users

## Visual Content Architecture

```text
┌─────────────────────────────────────────────────────────────────┐
│                    CMS INTERFACE DESIGN                         │
└─────────────────────────────────────────────────────────────────┘

MAIN NAVIGATION STRUCTURE:
┌──────────────────────────────────────────────────────────────┐
│  Dashboard | Posts | Articles | Projects | Talks | Pages     │
└──────────────────────────────────────────────────────────────┘

CONTENT TYPE MODULES (Sidebar):
┌────────────────────────────────────────────────────────────────┐
│ CONTENT TYPES                                                  │
├────────────────────────────────────────────────────────────────┤
│ Blog Posts (10)                  → YYYY/MM/DD hierarchy        │
│ Articles (1)                     → Flat in articles/           │
│ Projects (7)                     → Flat in projects/           │
│ Public Talks (4)                 → Flat with custom layout     │
│ Static Pages (2: About, CV)      → Root pages                  | 
│ Menu Management                  → Navigation config           │
│ Site Configuration               → hugo.toml params            │
└────────────────────────────────────────────────────────────────┘
```

## Content Type Editor Specifications

### 1. BLOG POSTS EDITOR

**Path:** `/content/posts/YYYY/MM/DD/slug/index.md`
**Frontmatter Type:** YAML (standardize to this)
**Required Fields:**

- Title (text input)
- Date (date+time picker) → Auto-generates path YYYY/MM/DD
- Content (markdown editor)

**Optional Fields:**

- Draft status (checkbox)
- Featured image (file picker) → Stores in post folder
- Additional images (multi-file picker) → Gallery support
- Tags (multi-select/autocomplete) → From existing tags
- Author (auto-filled: "pallotron")
- Description (textarea) → For SEO
- Categories (multi-select) → Currently inactive but available

**Asset Management:**

- Inline image upload → Saves to post's folder
- Directory structure: `/posts/YYYY/MM/DD/slug/`
  - `index.md`
  - `featured-image.jpg`
  - `/images/` (for galleries)
  - `/screenshots/` (for process docs)
  - `/videos/` (for embedded content)

### 2. ARTICLES EDITOR

**Path:** `/content/articles/slug/index.md`
**Similar to Blog Posts but:**

- Not date-hierarchical (flat structure)
- More metadata fields (author, description, categories are more important)
- Can be evergreen, evolving content (see: observations_outside_meta)
- Better for long-form, tutorial-style content

### 3. PROJECTS EDITOR

**Path:** `/content/projects/project-name.md`
**Frontmatter Type:** YAML
**Minimal Metadata:**

- Title
- Date (hidden from UI or optional)
- Draft status
- Content (markdown focused)

**Special Features:**

- No tags/categories
- Simpler form - focus on rich content
- Single optional featured image
- Related projects links (custom field?)

### 4. PUBLIC TALKS EDITOR

**Path:** `/content/public_talks/YYYY-event-name.md`
**Minimal Frontmatter:**

- Title
- Date
- Draft status
- Layout (force: "public_talks")
- Content (supports shortcodes for YouTube, slides, etc.)

### 5. STATIC PAGES EDITOR

**Path:** `/content/[about|cv].md`
**Simple Editor:**

- Title
- Featured image
- Content
- No date requirement

---

## Critical Design Decisions for CMS

### Problem 1: TOML vs YAML Inconsistency

**Current State:** Mixed usage
**Solution for CMS:**

- **Force YAML format** for all content (easier for UI)
- Convert existing TOML files on first import
- Never show format choice to users
- Backend: Parse either format, always save as YAML

**Frontend:** Hide frontmatter details from non-technical users

```text
INSTEAD OF: "Edit frontmatter fields"
USE: Auto-detecting form with:
  - Basic fields (Title, Date, Status)
  - Advanced fields (metadata, SEO, images)
  - Custom fields by content type
```

### Problem 2: Path Generation Complexity

**Current State:** Posts use YYYY/MM/DD/slug pattern
**Solution:**

```javascript
// Auto-generate path from date + slug
const postPath = `posts/${date.year}/${date.month}/${date.day}/${slug}/`;

// For non-posts: just /content-type/slug/
const otherPath = `${contentType}/${slug}/`;
```

**Frontend:** Single "Slug" input field that auto-populates from title

- User types title: "My Amazing Post"
- Auto-generate slug: "my-amazing-post"
- User can override if needed
- Show generated path preview below slug field

### Problem 3: Featured Image vs Images Array

**Current State:** Both fields exist, sometimes used together
**Solution:**

```text
UI Concept:
┌─────────────────────────────────────┐
│ Featured Image (Primary)             │
│ [Choose Image] [Upload New]         │
│                                     │
│ Additional Images (Gallery)         │
│ [Add Images] [Browse]               │
│ ☐ image1.jpg (Remove)              │
│ ☐ image2.jpg (Remove)              │
│ ☐ image3.jpg (Remove)              │
└─────────────────────────────────────┘

Maps to:
featured_image: "image1.jpg"
images: ["image1.jpg", "image2.jpg", "image3.jpg"]
```

### Problem 4: Tags vs Categories

**Current State:** Only tags configured as taxonomy, but categories used sporadically
**Solution:**

- **If keeping categories:** Add to config as proper taxonomy
- **Recommendation:** Remove categories, keep only tags
- UI: Single multi-select "Tags" field
- Pre-populate from existing tags
- Allow creating new tags on-the-fly (with confirmation)

### Problem 5: Menu Management

**Current State:** Hardcoded in hugo.toml with weight/order
**Solution for CMS:**

```text
Menu Editor UI:
┌──────────────────────────────────────┐
│ Navigation Menu Management           │
├──────────────────────────────────────┤
│ Icon | Name | URL | Order | Actions │
├──────────────────────────────────────┤
│ 👋   | About me | /about/ | 1 | ... │
│ 📝   | Resume | /cv/ | 2 | ... │
│ ⚙    | Projects | /projects/ | 3 | ... │
│ ... (drag to reorder) ... │
└──────────────────────────────────────┘

Updates hugo.toml [[menu.main]] array
```

---

## Feature Priority Matrix

### MVP (Must Have)

1. **Post creation/editing** (most content)
2. **Rich markdown editor** with preview
3. **Image upload** with asset colocation
4. **Draft/publish** workflow
5. **Tags management**
6. **Basic date selection**

### Phase 2 (Should Have)

1. **Multiple content types** (Articles, Projects, Talks)
2. **Featured image + images gallery**
3. **Scheduled publishing** (future dates)
4. **Content preview** (show how it looks on site)
5. **Basic analytics** (post views, traffic)
6. **SEO fields** (description, keywords)

### Phase 3 (Nice to Have)

1. **Automatic slug generation** from title
2. **Auto-save drafts**
3. **Revision history** (git integration)
4. **Content search** (full-text)
5. **Menu management UI**
6. **Theme customization** (colors, fonts)
7. **Social media preview** (OG tags)
8. **Bulk actions** (delete, publish multiple)

---

## Data Flow Architecture

```text
┌─────────────────────────────────────────────────────────────┐
│                    WEB INTERFACE                            │
│  (React/Vue form with live preview)                         │
└──────────────────┬──────────────────────────────────────────┘
                   │
                   ▼
┌─────────────────────────────────────────────────────────────┐
│                  CMS BACKEND API                            │
│  - Validate input                                           │
│  - Generate paths                                           │
│  - Manage assets                                            │
│  - Convert frontmatter format                               │
└──────────────────┬──────────────────────────────────────────┘
                   │
                   ▼
┌─────────────────────────────────────────────────────────────┐
│              FILE SYSTEM / GIT REPO                         │
│  /content/                                                  │
│  ├── posts/YYYY/MM/DD/slug/                                 │
│  │   ├── index.md (with YAML frontmatter)                   │
│  │   ├── featured-image.jpg                                 │
│  │   └── /images/                                           │
│  ├── projects/slug.md                                       │
│  └── ...                                                    │
│                                                             │
│  hugo.toml (config)                                         │
│  ├── params.social                                          │
│  ├── menu.main                                              │
│  └── params.home                                            │
└──────────────────┬──────────────────────────────────────────┘
                   │
                   ▼
┌─────────────────────────────────────────────────────────────┐
│              HUGO STATIC BUILD PROCESS                      │
│  hugo build ──► public/                                     | 
└──────────────────┬──────────────────────────────────────────┘
                   │
                   ▼
┌─────────────────────────────────────────────────────────────┐
│          DEPLOYED WEBSITE (Cloudflare Pages)                │
│  https://angelofailla.com/                                  │ 
└─────────────────────────────────────────────────────────────┘
```

---

## Recommended Tech Stack for CMS

### Frontend

- **Framework:** React or Vue.js (for live preview)
- **Editor:**
  - CodeMirror or Monaco (markdown with syntax highlighting)
  - Prosemirror/TipTap (rich editor alternative)
- **Components:**
  - React Hook Form + Zod (form handling + validation)
  - TailwindCSS (styling)

### Backend

- **Language:** Node.js/TypeScript (closest to Hugo ecosystem)
- **Framework:** Express or Next.js API routes
- **Tasks:**
  - Parse/generate frontmatter (YAML)
  - Manage file paths
  - Image optimization + upload
  - Git operations (commit/push)
  - Hugo build triggering

### File Management

- Direct file system access (since running on same machine as Hugo)
- OR: Git operations (commit/push to trigger CI/CD)
- Image optimization: Sharp or ImageMagick

### Preview/Build

- **Hugo binary integration** - call `hugo` directly
- **Pre-publish preview** - render HTML locally
- **Auto-rebuild on save** - trigger via webhook or direct call

---

## User Role Specification

### Author (Pallotron)

**Permissions:**

- Create/edit/delete all content
- Publish (draft → live)
- Schedule posts
- Manage tags
- Upload images
- Delete images/assets

**Cannot do:**

- Edit configuration (hugo.toml)
- Change theme
- Modify layouts
- Deploy to production (manual git push required)

### Proposed: Editor (future collaborator)

**Permissions:**

- Create/edit/delete own content
- Submit for review (stay as draft)
- Cannot publish without review
- Cannot delete other's content

**Cannot do:**

- Edit other author's content
- Access configuration
- Upload arbitrary files

---

## Content Governance

### Naming Conventions (Enforce in CMS)

```text
Blog Posts:
- Format: slug (lowercase, hyphens, no special chars)
- Length: 3-60 characters
- Example: "testing-with-linux-namespaces"

Projects:
- Format: same as posts
- Example: "expenses-analyzer"

Articles:
- Format: same as posts
- Example: "observations-outside-meta"

Tags:
- Format: lowercase, single words or hyphens
- Pre-approved list: [from existing tags]
- New tags: auto-created on use
```

### Required Fields by Type

```text
Posts:
  ✓ title, date, content
  
Articles:  
  ✓ title, date, content
  ✓ description (for SEO)
  
Projects:
  ✓ title, content
  
Pages:
  ✓ title, content
```

### Optional Fields (show in Advanced section)

```text
All types:
  - featured_image
  - images (array)
  - draft (default: false)
  - author (auto-fill)
  
Posts/Articles:
  - tags
  - categories
  - description
```
