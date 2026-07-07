'use client'

import Link from 'next/link'
import { Bot, Globe, Mail, Phone, MapPin } from 'lucide-react'

export function Footer() {
  return (
    <footer className="w-full border-t border-[var(--border)] bg-[var(--background)] px-6 py-12 md:px-20">
      <div className="mx-auto max-w-7xl">
        <div className="grid grid-cols-1 gap-10 md:grid-cols-4">
          {/* Brand Info */}
          <div className="md:col-span-2 space-y-4">
            <div className="flex items-center gap-3">
              <div className="flex h-9 w-9 items-center justify-center rounded-lg bg-button-gradient shadow-[0_4px_12px_rgba(217,119,6,0.2)] dark:shadow-[0_4px_12px_rgba(245,158,11,0.25)]">
                <Bot className="h-5 w-5 text-white dark:text-zinc-950" />
              </div>
              <span className="text-gradient text-lg font-extrabold">
                RoboGenius Tech
              </span>
            </div>
            <p className="text-sm leading-relaxed text-[var(--text-secondary)] max-w-sm">
              Transforming businesses with intelligent robotic process automation LLP. We build the future of work — today.
            </p>
            <div className="inline-block rounded-full border border-[var(--primary)]/20 bg-[var(--primary)]/5 px-3.5 py-1 text-xs font-semibold text-[var(--neon-blue)] tracking-wide">
              🤖 Automating the World
            </div>
          </div>

          {/* Quick Links */}
          <div className="space-y-4">
            <h4 className="text-sm font-bold text-[var(--text-primary)]">Quick Links</h4>
            <ul className="space-y-2.5 text-sm">
              <li>
                <Link href="/" className="text-[var(--text-secondary)] hover:text-[var(--neon-blue)] transition-colors">
                  Home
                </Link>
              </li>
              <li>
                <Link href="/services" className="text-[var(--text-secondary)] hover:text-[var(--neon-blue)] transition-colors">
                  Services
                </Link>
              </li>
              <li>
                <Link href="/about" className="text-[var(--text-secondary)] hover:text-[var(--neon-blue)] transition-colors">
                  About Us
                </Link>
              </li>
              <li>
                <Link href="/contact" className="text-[var(--text-secondary)] hover:text-[var(--neon-blue)] transition-colors">
                  Contact
                </Link>
              </li>
            </ul>
          </div>

          {/* Contact Details */}
          <div className="space-y-4">
            <h4 className="text-sm font-bold text-[var(--text-primary)]">Contact Info</h4>
            <ul className="space-y-3 text-xs leading-relaxed">
              <li className="flex items-start gap-2.5 text-[var(--text-secondary)]">
                <Mail className="h-4 w-4 shrink-0 text-[var(--neon-blue)]" />
                <span className="break-all">contact@robogeniustech.co.in</span>
              </li>
              <li className="flex items-start gap-2.5 text-[var(--text-secondary)]">
                <Phone className="h-4 w-4 shrink-0 text-[var(--neon-blue)]" />
                <span>+91 89283 82034</span>
              </li>
              <li className="flex items-start gap-2.5 text-[var(--text-secondary)]">
                <MapPin className="h-4 w-4 shrink-0 text-[var(--neon-blue)]" />
                <span>Mumbai, Maharashtra, India</span>
              </li>
            </ul>
          </div>
        </div>

        <div className="mt-10 border-t border-[var(--border)] pt-6 flex flex-col md:flex-row items-center justify-between gap-4">
          <p className="text-xs text-[var(--text-muted)]">
            © {new Date().getFullYear()} RoboGenius Tech. All rights reserved.
          </p>
          <div className="flex gap-3">
            <a
              href="https://robogeniustech.co.in"
              target="_blank"
              rel="noopener noreferrer"
              className="flex h-9 w-9 items-center justify-center rounded-lg border border-[var(--border)] text-[var(--text-muted)] hover:border-[var(--neon-blue)] hover:bg-[var(--neon-blue)]/10 hover:text-[var(--neon-blue)] transition-all"
            >
              <Globe className="h-4.5 w-4.5" />
            </a>
            <a
              href="mailto:contact@robogeniustech.co.in"
              className="flex h-9 w-9 items-center justify-center rounded-lg border border-[var(--border)] text-[var(--text-muted)] hover:border-[var(--neon-blue)] hover:bg-[var(--neon-blue)]/10 hover:text-[var(--neon-blue)] transition-all"
            >
              <Mail className="h-4.5 w-4.5" />
            </a>
            <a
              href="tel:+918928382034"
              className="flex h-9 w-9 items-center justify-center rounded-lg border border-[var(--border)] text-[var(--text-muted)] hover:border-[var(--neon-blue)] hover:bg-[var(--neon-blue)]/10 hover:text-[var(--neon-blue)] transition-all"
            >
              <Phone className="h-4.5 w-4.5" />
            </a>
          </div>
        </div>
      </div>
    </footer>
  )
}
