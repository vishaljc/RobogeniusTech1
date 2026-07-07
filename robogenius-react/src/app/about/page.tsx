'use client'

import { useState } from 'react'
import { motion } from 'framer-motion'
import { 
  Eye, Flag, Shield, Award, Users, Lightbulb, Handshake, 
  Target, ChevronRight, Brain, Cpu, Cloud, Code, Database, Terminal, Settings2
} from 'lucide-react'
import { Button } from '@/components/ui/button'

export default function About() {
  const timelineEvents = [
    { year: '2021', label: 'Founded' },
    { year: '2023', label: '15+ Projects' },
    { year: '2025', label: 'Incorporated as LLP' },
    { year: '2026', label: 'AI Expansion' },
  ]

  const techs = [
    { name: 'UiPath', icon: Cpu },
    { name: 'Automation Anywhere', icon: Settings2 },
    { name: 'Blue Prism', icon: Terminal },
    { name: 'React / Next.js', icon: Code },
    { name: 'Python / AI', icon: Brain },
    { name: 'Azure / AWS', icon: Cloud },
    { name: 'Power Automate', icon: ZapIcon },
    { name: 'SAP / Oracle', icon: Database },
  ]

  const values = [
    {
      icon: Lightbulb,
      title: 'Innovation First',
      desc: 'We continuously explore emerging automation technologies to stay ahead of the curve.'
    },
    {
      icon: Handshake,
      title: 'Client Partnership',
      desc: 'We embed ourselves in your business, learning your processes deeply before automating them.'
    },
    {
      icon: Target,
      title: 'Results-Driven',
      desc: 'Every engagement is measured against hard business KPIs — not just deliverables.'
    },
    {
      icon: Shield,
      title: 'Ethical Automation',
      desc: 'We build automation that augments human potential, never replaces it without purpose.'
    }
  ]

  // Helper inside component to render custom icons
  function ZapIcon(props: React.SVGProps<SVGSVGElement>) {
    return (
      <svg
        xmlns="http://www.w3.org/2000/svg"
        viewBox="0 0 24 24"
        fill="none"
        stroke="currentColor"
        strokeWidth="2"
        strokeLinecap="round"
        strokeLinejoin="round"
        {...props}
      >
        <polygon points="13 2 3 14 12 14 11 22 21 10 12 10 13 2" />
      </svg>
    )
  }

  return (
    <div className="w-full relative overflow-x-hidden flex flex-col">
      
      {/* --- HERO SECTION --- */}
      <section className="relative w-full py-16 md:py-24 px-6 md:px-20 bg-hero-gradient border-b border-stone-200 dark:border-stone-900">
        <div className="absolute top-[-10%] left-[-10%] h-[350px] w-[350px] rounded-full bg-[var(--primary)]/5 blur-[100px] pointer-events-none" />
        <div className="absolute bottom-[10%] right-[-10%] h-[350px] w-[350px] rounded-full bg-[var(--primary)]/5 blur-[100px] pointer-events-none" />

        <div className="mx-auto max-w-7xl w-full grid grid-cols-1 lg:grid-cols-12 gap-12 items-center z-10">
          {/* Left Text */}
          <div className="lg:col-span-7 space-y-6 text-left">
            <motion.div 
              initial={{ opacity: 0, scale: 0.95 }}
              animate={{ opacity: 1, scale: 1 }}
              className="inline-flex items-center gap-2 rounded-full border border-[var(--primary)]/20 bg-[var(--primary)]/5 px-4 py-1.5"
            >
              <span className="text-[10px] sm:text-xs font-bold tracking-[0.08em] text-[var(--neon-blue)] uppercase">
                ABOUT ROBOGENIUS
              </span>
            </motion.div>

            <motion.h1 
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ duration: 0.6, delay: 0.1 }}
              className="text-4xl md:text-6xl font-black font-heading tracking-tight leading-[1.1]"
            >
              Building the<br />
              <span className="text-gradient">
                Future of Work
              </span>
            </motion.h1>

            <motion.p 
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ duration: 0.6, delay: 0.2 }}
              className="text-base md:text-lg leading-relaxed text-stone-600 dark:text-stone-400"
            >
              RoboGenius Tech is a technology company on a mission to eliminate manual work through intelligent automation. 
              Founded with a vision to democratise RPA for businesses of every size, we&apos;ve delivered over 100 automation 
              solutions across industries.
            </motion.p>

            <motion.div
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ duration: 0.6, delay: 0.3 }}
              className="pt-2"
            >
              <Button variant="outline" className="border-stone-300 dark:border-stone-800 text-[var(--neon-blue)] hover:bg-[var(--primary)]/10 font-bold px-6 flex items-center gap-2 cursor-pointer transition-all hover:scale-[1.02] active:scale-[0.98]">
                Our Story
                <ChevronRight className="h-4.5 w-4.5" />
              </Button>
            </motion.div>
          </div>

          {/* Right Timeline Panel */}
          <motion.div 
            initial={{ opacity: 0, x: 30 }}
            animate={{ opacity: 1, x: 0 }}
            transition={{ duration: 0.7, delay: 0.2 }}
            className="lg:col-span-5 p-8 rounded-3xl glass-panel relative flex flex-col justify-center min-h-[300px] border-stone-200 dark:border-stone-850 bg-[var(--card)]"
          >
            <h3 className="text-lg font-bold font-heading mb-8 text-[var(--text-primary)]">Our Journey</h3>
            <div className="relative pl-6 border-l-2 border-stone-200 dark:border-stone-850 space-y-8">
              {timelineEvents.map((evt, idx) => (
                <div key={evt.year} className="relative">
                  <div className="absolute -left-[31px] top-1.5 h-4.5 w-4.5 rounded-full border border-stone-200 dark:border-stone-850 bg-[var(--background)] flex items-center justify-center">
                    <div className="h-2.5 w-2.5 rounded-full bg-button-gradient" />
                  </div>
                  <div className="space-y-1">
                    <span className="text-xs font-black tracking-wider text-[var(--neon-blue)] uppercase">
                      {evt.year}
                    </span>
                    <h4 className="text-sm font-bold text-[var(--text-primary)]">
                      {evt.label}
                    </h4>
                  </div>
                </div>
              ))}
            </div>
          </motion.div>
        </div>
      </section>

      {/* --- MISSION & VISION --- */}
      <section className="w-full py-16 md:py-24 px-6 md:px-20 bg-gradient-to-b from-[var(--background)] to-[var(--surface-light)] border-b border-stone-200 dark:border-stone-900">
        <div className="mx-auto max-w-7xl">
          <div className="text-center space-y-4 max-w-3xl mx-auto">
            <div className="inline-flex items-center gap-2 rounded-full border border-[var(--primary)]/20 bg-[var(--primary)]/5 px-3 py-1">
              <span className="text-[10px] sm:text-xs font-bold tracking-[0.08em] text-[var(--neon-blue)] uppercase">
                OUR PURPOSE
              </span>
            </div>
            <h2 className="text-3xl md:text-5xl font-extrabold font-heading leading-tight text-[var(--text-primary)]">
              Driven by Vision,<br />Defined by Impact
            </h2>
            <p className="text-sm md:text-base text-stone-600 dark:text-stone-400">
              Every line of code, every bot deployed, every process automated — all in service of one purpose.
            </p>
          </div>

          <div className="mt-16 grid grid-cols-1 md:grid-cols-2 gap-8">
            {/* Vision */}
            <motion.div
              initial={{ opacity: 0, y: 20 }}
              whileInView={{ opacity: 1, y: 0 }}
              viewport={{ once: true }}
              transition={{ duration: 0.6 }}
              className="p-8 md:p-10 rounded-3xl glass-panel glass-panel-hover flex flex-col gap-6 border-t border-t-[var(--primary)]/30 border-stone-250 dark:border-stone-800 bg-[var(--card)]"
            >
              <div className="flex items-center gap-4">
                <div className="h-12 w-12 rounded-xl flex items-center justify-center bg-[var(--primary)]/8 text-[var(--neon-blue)] border border-[var(--primary)]/10">
                  <Eye className="h-6 w-6" />
                </div>
                <div>
                  <span className="text-[10px] font-black tracking-widest text-[var(--neon-blue)] uppercase">
                    VISION
                  </span>
                  <h3 className="text-xl font-bold font-heading text-[var(--text-primary)]">
                    A World Without Manual Work
                  </h3>
                </div>
              </div>
              <p className="text-sm md:text-base leading-relaxed text-stone-600 dark:text-stone-400 flex-1">
                We envision a future where every repetitive business process is handled by intelligent automation, 
                freeing humans to focus on creativity, strategy, and innovation.
              </p>
            </motion.div>

            {/* Mission */}
            <motion.div
              initial={{ opacity: 0, y: 20 }}
              whileInView={{ opacity: 1, y: 0 }}
              viewport={{ once: true }}
              transition={{ duration: 0.6, delay: 0.1 }}
              className="p-8 md:p-10 rounded-3xl glass-panel glass-panel-hover flex flex-col gap-6 border-t border-t-[var(--primary)]/30 border-stone-250 dark:border-stone-800 bg-[var(--card)]"
            >
              <div className="flex items-center gap-4">
                <div className="h-12 w-12 rounded-xl flex items-center justify-center bg-[var(--primary)]/8 text-[var(--neon-blue)] border border-[var(--primary)]/10">
                  <Flag className="h-6 w-6" />
                </div>
                <div>
                  <span className="text-[10px] font-black tracking-widest text-[var(--neon-blue)] uppercase">
                    MISSION
                  </span>
                  <h3 className="text-xl font-bold font-heading text-[var(--text-primary)]">
                    Democratise Intelligent Automation
                  </h3>
                </div>
              </div>
              <p className="text-sm md:text-base leading-relaxed text-stone-600 dark:text-stone-400 flex-1">
                We make enterprise-grade RPA and AI solutions accessible to businesses of every size — delivering 
                measurable ROI, faster processes, and zero-error execution.
              </p>
            </motion.div>
          </div>
        </div>
      </section>

      {/* --- TECH STACK --- */}
      <section className="w-full py-16 md:py-24 px-6 md:px-20 bg-gradient-to-b from-[var(--surface-light)] to-[var(--background)] border-b border-stone-200 dark:border-stone-900">
        <div className="mx-auto max-w-7xl">
          <div className="text-center space-y-4 max-w-3xl mx-auto">
            <div className="inline-flex items-center gap-2 rounded-full border border-[var(--primary)]/20 bg-[var(--primary)]/5 px-3 py-1">
              <span className="text-[10px] sm:text-xs font-bold tracking-[0.08em] text-[var(--neon-blue)] uppercase">
                TECHNOLOGY
              </span>
            </div>
            <h2 className="text-3xl md:text-5xl font-extrabold font-heading leading-tight text-[var(--text-primary)]">
              Expertise Across<br />Leading Platforms
            </h2>
            <p className="text-sm md:text-base text-stone-600 dark:text-stone-400">
              We are certified partners and practitioners across the world&apos;s leading RPA and automation platforms.
            </p>
          </div>

          <div className="mt-16 grid grid-cols-2 md:grid-cols-4 gap-4">
            {techs.map((tech, i) => {
              const Icon = tech.icon
              return (
                <motion.div
                  key={tech.name}
                  initial={{ opacity: 0, y: 15 }}
                  whileInView={{ opacity: 1, y: 0 }}
                  viewport={{ once: true }}
                  transition={{ duration: 0.4, delay: i * 0.05 }}
                  className="flex flex-col items-center justify-center p-6 rounded-2xl glass-panel glass-panel-hover group cursor-default border-stone-200 dark:border-stone-850 bg-[var(--card)]"
                >
                  <Icon className="h-7 w-7 text-stone-500 group-hover:text-[var(--neon-blue)] mb-3 transition-colors duration-300" />
                  <span className="text-sm font-semibold text-stone-600 group-hover:text-[var(--text-primary)] transition-colors duration-300">
                    {tech.name}
                  </span>
                </motion.div>
              )
            })}
          </div>
        </div>
      </section>

      {/* --- VALUES --- */}
      <section className="w-full py-16 md:py-24 px-6 md:px-20 bg-[var(--background)]">
        <div className="mx-auto max-w-7xl">
          <div className="text-center space-y-4 max-w-3xl mx-auto">
            <div className="inline-flex items-center gap-2 rounded-full border border-[var(--primary)]/20 bg-[var(--primary)]/5 px-3 py-1">
              <span className="text-[10px] sm:text-xs font-bold tracking-[0.08em] text-[var(--neon-blue)] uppercase">
                OUR VALUES
              </span>
            </div>
            <h2 className="text-3xl md:text-5xl font-extrabold font-heading leading-tight text-[var(--text-primary)]">
              Principles That<br />Guide Every Decision
            </h2>
            <p className="text-sm md:text-base text-stone-600 dark:text-stone-400">
              Our LLP culture and values shape how we build, deliver, and partner.
            </p>
          </div>

          <div className="mt-16 grid grid-cols-1 md:grid-cols-2 gap-6">
            {values.map((item, i) => {
              const Icon = item.icon
              return (
                <motion.div
                  key={item.title}
                  initial={{ opacity: 0, y: 20 }}
                  whileInView={{ opacity: 1, y: 0 }}
                  viewport={{ once: true }}
                  transition={{ duration: 0.5, delay: 0.08 * i }}
                  className="flex gap-5 p-8 rounded-3xl glass-panel glass-panel-hover group border-stone-200 dark:border-stone-850 bg-[var(--card)]"
                >
                  <div className="flex-shrink-0 h-12 w-12 rounded-xl flex items-center justify-center bg-[var(--primary)]/8 text-[var(--neon-blue)] group-hover:bg-button-gradient group-hover:text-white transition-all duration-300 border border-[var(--primary)]/10">
                    <Icon className="h-6 w-6" />
                  </div>
                  <div className="space-y-2 text-left">
                    <h3 className="text-lg font-bold font-heading text-[var(--text-primary)] group-hover:text-[var(--neon-blue)] transition-colors">
                      {item.title}
                    </h3>
                    <p className="text-sm text-stone-600 dark:text-stone-400 leading-relaxed">
                      {item.desc}
                    </p>
                  </div>
                </motion.div>
              )
            })}
          </div>
        </div>
      </section>

    </div>
  )
}
