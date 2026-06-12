export default function Loading() {
  return (
    <main className="min-h-screen max-w-7xl mx-auto p-8">
      <div className="animate-pulse space-y-6">
        <div className="h-10 w-64 rounded-lg bg-[#eadfcb]" />
        <div className="h-5 w-full max-w-2xl rounded bg-[#eadfcb]" />
        <div className="grid gap-4 md:grid-cols-3">
          <div className="h-40 rounded-2xl border border-[#c9b895] bg-[#fffaf0]" />
          <div className="h-40 rounded-2xl border border-[#c9b895] bg-[#fffaf0]" />
          <div className="h-40 rounded-2xl border border-[#c9b895] bg-[#fffaf0]" />
        </div>
      </div>
    </main>
  );
}
