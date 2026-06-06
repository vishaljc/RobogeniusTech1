'use client'

import { useState, useEffect } from 'react'
import Link from 'next/link'
import { usePathname } from 'next/navigation'
import { useTheme } from 'next-themes'
import { Bot, Sun, Moon, Menu, X, ArrowRight } from 'lucide-react'
import { Button } from '@/components/ui/button'
import { motion, AnimatePresence } from 'framer-motion'

export function Navbar() {
  const pathname = usePathname()
  const { theme, setTheme, resolvedTheme } = useTheme()
  const [mounted, setMounted] = useState(false)
  const [mobileMenuOpen, setMobileMenuOpen] = useState(false)
  const [hoveredIndex, setHoveredIndex] = useState<number | null>(null)

  // Avoid Hydration mismatch
  useEffect(() => {
    setMounted(true)
  }, [])

  const navLinks = [
    { name: 'Home', href: '/' },
    { name: 'Services', href: '/services' },
    { name: 'About', href: '/about' },
    { name: 'Contact', href: '/contact' },
  ]

  const activeLink = (href: string) => {
    if (href === '/') {
      return pathname === '/'
    }
    return pathname.startsWith(href)
  }

  const toggleTheme = () => {
    setTheme(resolvedTheme === 'dark' ? 'light' : 'dark')
  }

  return (
    <motion.header 
      layout
      transition={{
        type: 'spring',
        stiffness: 280,
        damping: 30,
        mass: 0.8
      }}
      className={`fixed top-6 left-1/2 -translate-x-1/2 z-50 w-[92%] max-w-5xl border bg-white/75 dark:bg-zinc-950/60 backdrop-blur-xl transition-all duration-500 shadow-[0_8px_32px_rgba(0,0,0,0.08)] dark:shadow-[0_8px_32px_rgba(0,0,0,0.5)] border-zinc-200 dark:border-white/10 hover:border-amber-500/30 dark:hover:border-[#ffcd75]/35 overflow-hidden ${
        mobileMenuOpen ? 'rounded-[32px]' : 'rounded-full'
      }`}
    >
      <div className="flex h-14 items-center justify-between px-6">
        {/* Logo */}
        <Link href="/" className="flex items-center gap-2.5">
          <div className="flex h-9 w-9 items-center justify-center rounded-lg bg-button-gradient shadow-[0_4px_12px_rgba(194,122,0,0.2)] dark:shadow-[0_4px_12px_rgba(255,205,117,0.3)]">
            <Bot className="h-5 w-5 text-white dark:text-zinc-950" />
          </div>
          <span className="text-gradient text-lg font-extrabold tracking-tight">
            RoboGenius Tech
          </span>
        </Link>

        {/* Desktop Nav Links with Liquid Hover / Active Indicator */}
        <nav 
          className="hidden md:flex items-center gap-1 relative"
          onMouseLeave={() => setHoveredIndex(null)}
        >
          {navLinks.map((link, index) => {
            const isActive = activeLink(link.href)
            const isHovered = hoveredIndex === index
            const isCurrent = isHovered || (hoveredIndex === null && isActive)
            return (
              <Link
                key={link.name}
                href={link.href}
                onMouseEnter={() => setHoveredIndex(index)}
                className={`relative px-4 py-1.5 text-sm font-semibold transition-colors duration-300 rounded-full cursor-pointer z-10 ${
                  isCurrent 
                    ? 'text-white dark:text-zinc-950' 
                    : 'text-zinc-600 dark:text-zinc-400 hover:text-zinc-900 dark:hover:text-white'
                }`}
              >
                {/* Liquid sliding pill indicator */}
                {isCurrent && (
                  <motion.div
                    layoutId="navbar-active-pill"
                    className="absolute inset-0 bg-gradient-to-r from-zinc-950 to-[#c27a00] dark:from-white dark:to-[#ffcd75] rounded-full -z-10 shadow-[0_2px_10px_rgba(194,122,0,0.15)] dark:shadow-[0_2px_10px_rgba(255,205,117,0.2)]"
                    transition={{
                      type: 'spring',
                      stiffness: 380,
                      damping: 28,
                      mass: 0.8
                    }}
                  />
                )}
                <span>{link.name}</span>
              </Link>
            )
          })}
        </nav>

        {/* Right side items (Theme toggle + CTA + Mobile menu button) */}
        <div className="flex items-center gap-4">
          {/* Theme Toggle */}
          {mounted && (
            <button
              onClick={toggleTheme}
              className="flex h-9 w-9 items-center justify-center rounded-lg border border-[var(--border)] text-[var(--text-secondary)] hover:border-[var(--neon-blue)] hover:bg-[var(--neon-blue)]/10 hover:text-[var(--neon-blue)] transition-all cursor-pointer"
              aria-label="Toggle theme"
            >
              {resolvedTheme === 'dark' ? (
                <Sun className="h-4.5 w-4.5" />
              ) : (
                <Moon className="h-4.5 w-4.5" />
              )}
            </button>
          )}

          {/* Contact CTA */}
          <Link href="/contact" className="hidden md:block">
            <Button className="bg-zinc-950 text-white hover:bg-zinc-800 dark:bg-white dark:text-zinc-950 dark:hover:bg-zinc-200 rounded-full font-semibold transition-all hover:scale-[1.02] active:scale-[0.98] flex items-center gap-1.5 cursor-pointer shadow-[0_4px_12px_rgba(0,0,0,0.1)] dark:shadow-none">
              Get Assessment
              <ArrowRight className="h-4 w-4" />
            </Button>
          </Link>

          {/* Mobile Menu Toggle */}
          <button
            onClick={() => setMobileMenuOpen(!mobileMenuOpen)}
            className="md:hidden flex h-9 w-9 items-center justify-center rounded-lg border border-[var(--border)] text-[var(--text-secondary)] hover:border-[var(--neon-blue)] hover:bg-[var(--neon-blue)]/10 hover:text-[var(--neon-blue)] transition-all cursor-pointer"
            aria-label="Toggle mobile menu"
          >
            {mobileMenuOpen ? (
              <X className="h-5 w-5" />
            ) : (
              <Menu className="h-5 w-5" />
            )}
          </button>
        </div>
      </div>

      {/* Mobile Menu Panel with dynamic fluid animation */}
      <AnimatePresence>
        {mobileMenuOpen && (
          <motion.div 
            initial={{ opacity: 0, height: 0 }}
            animate={{ opacity: 1, height: 'auto' }}
            exit={{ opacity: 0, height: 0 }}
            transition={{ type: 'spring', stiffness: 300, damping: 30 }}
            className="md:hidden px-6 pb-6 overflow-hidden"
          >
            <nav className="flex flex-col gap-3.5 pt-2 border-t border-zinc-200 dark:border-white/5">
              {navLinks.map((link) => (
                <Link
                  key={link.name}
                  href={link.href}
                  onClick={() => setMobileMenuOpen(false)}
                  className={`text-sm font-semibold py-2 transition-colors ${
                    activeLink(link.href)
                      ? 'text-[var(--neon-blue)]'
                      : 'text-zinc-600 dark:text-zinc-400 hover:text-zinc-900 dark:hover:text-white'
                  }`}
                >
                  {link.name}
                </Link>
              ))}
              <Link
                href="/contact"
                onClick={() => setMobileMenuOpen(false)}
                className="mt-2"
              >
                <Button className="w-full bg-zinc-950 text-white hover:bg-zinc-800 dark:bg-white dark:text-zinc-950 dark:hover:bg-zinc-200 rounded-full font-semibold flex items-center justify-center gap-2">
                  Get Assessment
                  <ArrowRight className="h-4 w-4" />
                </Button>
              </Link>
            </nav>
          </motion.div>
        )}
      </AnimatePresence>
    </motion.header>
  )
}
