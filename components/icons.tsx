type IconProps = {
  className?: string;
};

const base = "stroke-current fill-none";

export function MenuIcon({ className }: IconProps) {
  return (
    <svg viewBox="0 0 24 24" className={className} strokeWidth={1.5}>
      <path className={base} strokeLinecap="round" d="M3 6h18M3 12h18M3 18h18" />
    </svg>
  );
}

export function SearchIcon({ className }: IconProps) {
  return (
    <svg viewBox="0 0 24 24" className={className} strokeWidth={1.5}>
      <circle className={base} cx="11" cy="11" r="7" />
      <path className={base} strokeLinecap="round" d="M21 21l-4.3-4.3" />
    </svg>
  );
}

export function BookmarkIcon({ className, filled }: IconProps & { filled?: boolean }) {
  return (
    <svg viewBox="0 0 24 24" className={className} strokeWidth={1.5}>
      <path
        className={base}
        fill={filled ? "currentColor" : "none"}
        strokeLinejoin="round"
        d="M6 3.5h12a1 1 0 0 1 1 1V21l-7-4-7 4V4.5a1 1 0 0 1 1-1Z"
      />
    </svg>
  );
}

export function UserIcon({ className }: IconProps) {
  return (
    <svg viewBox="0 0 24 24" className={className} strokeWidth={1.5}>
      <circle className={base} cx="12" cy="8.5" r="3.5" />
      <path className={base} strokeLinecap="round" d="M4.5 20a7.5 7.5 0 0 1 15 0" />
    </svg>
  );
}

export function ChevronLeftIcon({ className }: IconProps) {
  return (
    <svg viewBox="0 0 24 24" className={className} strokeWidth={1.6}>
      <path className={base} strokeLinecap="round" strokeLinejoin="round" d="M15 5l-7 7 7 7" />
    </svg>
  );
}

export function ChevronRightIcon({ className }: IconProps) {
  return (
    <svg viewBox="0 0 24 24" className={className} strokeWidth={1.6}>
      <path className={base} strokeLinecap="round" strokeLinejoin="round" d="M9 5l7 7-7 7" />
    </svg>
  );
}

export function ChevronDownIcon({ className }: IconProps) {
  return (
    <svg viewBox="0 0 24 24" className={className} strokeWidth={1.6}>
      <path className={base} strokeLinecap="round" strokeLinejoin="round" d="M5 9l7 7 7-7" />
    </svg>
  );
}

export function CrossIcon({ className }: IconProps) {
  return (
    <svg viewBox="0 0 24 24" className={className} strokeWidth={1.5}>
      <path className={base} strokeLinecap="round" d="M12 3v18M6 8h12" />
    </svg>
  );
}

export function CompassIcon({ className }: IconProps) {
  return (
    <svg viewBox="0 0 24 24" className={className} strokeWidth={1.3}>
      <circle className={base} cx="12" cy="12" r="9.5" />
      <path
        className={base}
        strokeLinejoin="round"
        fill="currentColor"
        d="M15.5 8.5 13 13l-4.5 2.5L11 11l4.5-2.5Z"
      />
    </svg>
  );
}

export function LayersIcon({ className }: IconProps) {
  return (
    <svg viewBox="0 0 24 24" className={className} strokeWidth={1.4}>
      <path className={base} strokeLinejoin="round" d="M12 3.5 3 8l9 4.5 9-4.5-9-4.5Z" />
      <path className={base} strokeLinejoin="round" d="M3 12.5 12 17l9-4.5" />
      <path className={base} strokeLinejoin="round" d="M3 16.5 12 21l9-4.5" />
    </svg>
  );
}

export function ClockIcon({ className }: IconProps) {
  return (
    <svg viewBox="0 0 24 24" className={className} strokeWidth={1.4}>
      <circle className={base} cx="12" cy="12" r="9" />
      <path className={base} strokeLinecap="round" strokeLinejoin="round" d="M12 7v5l3.5 2" />
    </svg>
  );
}

export function DomeIcon({ className }: IconProps) {
  return (
    <svg viewBox="0 0 24 24" className={className} strokeWidth={1.4}>
      <path className={base} strokeLinecap="round" d="M12 2.5v2.2" />
      <path className={base} strokeLinejoin="round" d="M6.5 11.5a5.5 5.5 0 0 1 11 0Z" />
      <path className={base} strokeLinecap="round" d="M4.5 11.5h15" />
      <path className={base} strokeLinecap="round" d="M6 11.5V19h12v-7.5" />
      <path className={base} strokeLinecap="round" d="M4 21h16" />
    </svg>
  );
}

export function FootprintsIcon({ className }: IconProps) {
  return (
    <svg viewBox="0 0 24 24" className={className} strokeWidth={1.4}>
      <ellipse className={base} cx="8" cy="7" rx="2.2" ry="3" transform="rotate(-15 8 7)" />
      <ellipse className={base} cx="16" cy="14.5" rx="2.2" ry="3" transform="rotate(15 16 14.5)" />
    </svg>
  );
}

export function InfoIcon({ className }: IconProps) {
  return (
    <svg viewBox="0 0 24 24" className={className} strokeWidth={1.4}>
      <circle className={base} cx="12" cy="12" r="9" />
      <path className={base} strokeLinecap="round" d="M12 11v5.5" />
      <circle cx="12" cy="8" r="0.9" fill="currentColor" stroke="none" />
    </svg>
  );
}

export function BookIcon({ className }: IconProps) {
  return (
    <svg viewBox="0 0 24 24" className={className} strokeWidth={1.4}>
      <path
        className={base}
        strokeLinejoin="round"
        d="M4 5.5c2.5-1 5.5-1 8 0v13c-2.5-1-5.5-1-8 0v-13Z"
      />
      <path
        className={base}
        strokeLinejoin="round"
        d="M20 5.5c-2.5-1-5.5-1-8 0v13c2.5-1 5.5-1 8 0v-13Z"
      />
    </svg>
  );
}

export function MedalIcon({ className }: IconProps) {
  return (
    <svg viewBox="0 0 24 24" className={className} strokeWidth={1.4}>
      <circle className={base} cx="12" cy="9" r="6" />
      <path className={base} strokeLinecap="round" strokeLinejoin="round" d="M9 14.5 7 21l5-2.5L17 21l-2-6.5" />
    </svg>
  );
}
