-- ==========================================
-- 1. Users Table
-- ==========================================
CREATE TABLE public.users (
  id uuid PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  created_at timestamptz NOT NULL DEFAULT now()
);

ALTER TABLE public.users ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can manage their own profile"
ON public.users
FOR ALL
USING (id = auth.uid())
WITH CHECK (id = auth.uid());


-- ==========================================
-- 2. Templates Table
-- ==========================================
CREATE TABLE public.templates (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
  name text NOT NULL,
  hourly_rate numeric NOT NULL,
  default_start_time time NOT NULL,
  default_end_time time NOT NULL,
  unpaid_break_minutes integer NOT NULL DEFAULT 0
);

ALTER TABLE public.templates ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can manage their own templates"
ON public.templates
FOR ALL
USING (user_id = auth.uid())
WITH CHECK (user_id = auth.uid());


-- ==========================================
-- 3. Shifts Table
-- ==========================================
CREATE TABLE public.shifts (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
  template_id uuid REFERENCES public.templates(id) ON DELETE SET NULL,
  location_name text,
  start_time timestamptz NOT NULL,
  end_time timestamptz NOT NULL,
  unpaid_break_minutes integer NOT NULL DEFAULT 0,
  hourly_rate numeric NOT NULL,
  total_earned numeric NOT NULL,
  source text NOT NULL,
  created_at timestamptz NOT NULL DEFAULT now()
);

ALTER TABLE public.shifts ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can manage their own shifts"
ON public.shifts
FOR ALL
USING (user_id = auth.uid())
WITH CHECK (user_id = auth.uid());