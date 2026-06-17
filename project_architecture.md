Last Updated: Sprint Day 1 - Foundation

1. Core Tech Stack Restrictions
All agents must strictly adhere to this stack. Do not introduce alternatives.

Frontend: React + Vite + TypeScript + Tailwind + Shadcn (UI) + Tabler (Icons) + Animate-ui.

State & Caching: TanStack Query is mandatory for all data fetching to eliminate loading spinners and ensure instant, offline-ready loads.

Backend & Database: Supabase Postgres, Supabase Storage, and Supabase Auth.

AI Engine: OCR and Gemini Flash logic must run exclusively inside Supabase Edge Functions.

Infrastructure: Cloudflare (DNS, Pages), Resend (Email), Sentry (Errors).

2. Database Schema (Supabase Postgres)
Note: All tables must have Row Level Security (RLS) enabled, strictly enforcing user_id = auth.uid().

users
Managed by Supabase Auth, but extended via a public profile table if needed.

id (uuid, PK, references auth.users)

created_at (timestamptz)

templates
Supports the "Templated Manual Entry" feature.

id (uuid, PK)

user_id (uuid, FK)

name (text) - e.g., "Starbucks Morning"

hourly_rate (numeric)

default_start_time (time)

default_end_time (time)

unpaid_break_minutes (int)

shifts
The core engine. Tracks all individual work blocks.

id (uuid, PK)

user_id (uuid, FK)

template_id (uuid, FK, nullable)

location_name (text, nullable)

start_time (timestamptz)

end_time (timestamptz)

unpaid_break_minutes (int)

hourly_rate (numeric)

total_earned (numeric) - Pre-calculated upon entry.

source (text) - e.g., 'manual', 'smart_add'

created_at (timestamptz)

3. Strict Boundary Rules
Zero Scope Creep: There is absolutely no logic for Singapore CPF, tax, or statutory deductions. Store gross earnings only.

UX Friction: Minimum touch target size is 44px × 44px.

Typography: The font is Inter. All financial totals and shift hours must use tabular-nums (font-variant-numeric: tabular-nums).

Color Scarcity: Stack Blue (#0052ff) is reserved exclusively for primary action pills and active states.

[SYSTEM_STATE]
Current Phase: Day 1 Foundation / Repository Setup

Core Schema: v1.0 Defined (Users, Templates, Shifts)

Active APIs/Edge Functions: None

Pending Action: Awaiting the CEO to commit project_architecture.md to main, then provide the Supabase SQL script from the Backend Engineer Agent on branch chore/db/init-core-schema.