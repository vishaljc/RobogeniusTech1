'use client'

import { useState, useEffect } from 'react'
import Link from 'next/link'
import { motion } from 'framer-motion'
import { 
  Bot, Rocket, ArrowRight, ShieldCheck, Zap, Award, 
  Users, CheckCircle2, Star, TrendingUp, Cpu, Network, Clock,
  Play, Target, Crown, Hexagon, Triangle, Command, Ghost, Gem
} from 'lucide-react'
import { Button } from '@/components/ui/button'
import { Card } from '@/components/ui/card'
import { Spotlight } from '@/components/ui/spotlight'
import { SplineScene } from '@/components/ui/splite'

// --- Stats Counter ---
function StatItem({ value, suffix, label, delay }: { value: number; suffix: string; label: string; delay: number }) {
  const [count, setCount] = useState(0)

  useEffect(() => {
    let start = 0
    const end = value
    if (start === end) return

    const duration = 2 // seconds
    const totalMiliseconds = duration * 1000
    const stepTime = Math.abs(Math.floor(totalMiliseconds / end))
    
    // Slight delay before counting
    const timeout = setTimeout(() => {
      const timer = setInterval(() => {
        start += 1
        setCount(start)
        if (start === end) {
          clearInterval(timer)
        }
      }, Math.max(stepTime, 15))
    }, delay * 1000)

    return () => {
      clearTimeout(timeout)
    }
  }, [value, delay])

  return (
    <motion.div
      initial={{ opacity: 0, y: 20 }}
      whileInView={{ opacity: 1, y: 0 }}
      viewport={{ once: true }}
      transition={{ duration: 0.6, delay }}
      className="flex flex-col items-center justify-center p-6 rounded-3xl glass-panel glass-panel-hover group"
    >
      <div className="text-gradient text-4xl md:text-5xl font-black">
        {count || value}
        {suffix}
      </div>
      <p className="mt-2 text-sm font-semibold text-[var(--text-secondary)] text-center group-hover:text-[var(--text-primary)] transition-colors">
        {label}
      </p>
    </motion.div>
  )
}

// --- Home Screen ---
export default function Home() {
  const services = [
    {
      id: 'rpa',
      title: 'Robotic Process Automation',
      desc: 'Automate repetitive tasks with intelligent software robots that work 24/7.',
      icon: Cpu,
      color: 'var(--neon-blue)',
    },
    {
      id: 'ai',
      title: 'AI & Machine Learning',
      desc: 'Harness the power of AI to derive insights, predict outcomes, and automate decisions.',
      icon: Bot,
      color: 'var(--neon-purple)',
    },
    {
      id: 'mobile',
      title: 'Mobile App Development',
      desc: 'Native and cross-platform mobile apps for Android & iOS with cutting-edge UX.',
      icon: Rocket,
      color: 'var(--neon-cyan)',
    },
    {
      id: 'web',
      title: 'Web Development',
      desc: 'Scalable, high-performance web applications built on modern tech stacks.',
      icon: Network,
      color: 'var(--neon-blue)',
    },
    {
      id: 'uiux',
      title: 'UI/UX Design',
      desc: 'Intuitive, research-driven design systems that delight users and drive conversion.',
      icon: Award,
      color: 'var(--neon-purple)',
    },
  ]

  const reasons = [
    {
      icon: Cpu,
      title: 'Enterprise-Grade Automation',
      desc: 'We deploy robust RPA bots built for high-volume, mission-critical environments. Our automations are tested, monitored, and continuously optimised.'
    },
    {
      icon: Zap,
      title: 'Rapid Deployment',
      desc: '80% faster go-live than traditional software projects. Our pre-built automation frameworks slash implementation time dramatically.'
    },
    {
      icon: Network,
      title: 'End-to-End Integration',
      desc: 'Seamlessly connect ERPs, CRMs, legacy systems, and cloud platforms. No system is off-limits for our automation engineers.'
    },
    {
      icon: Clock,
      title: '24/7 Bot Operations',
      desc: 'Our robotic workforce never sleeps. Processes run around the clock with real-time monitoring, alerting, and exception handling.'
    },
    {
      icon: TrendingUp,
      title: 'Measurable ROI',
      desc: 'Every automation is mapped to KPIs. Track cost savings, FTE reduction, and error rates on live dashboards from day one.'
    },
    {
      icon: ShieldCheck,
      title: 'Security & Compliance',
      desc: 'SOC-2 ready architecture with full audit trails, role-based access, and compliance frameworks built into every automation.'
    }
  ]

  const testimonials = [
    {
      quote: 'RoboGenius automated our entire invoice processing pipeline. We went from 3 days per cycle to 2 hours. The ROI paid for itself in 6 weeks.',
      name: 'Rajesh Mehta',
      role: 'CFO, FinServ India',
      icon: Users
    },
    {
      quote: 'Their RPA bots handle 12,000+ transactions daily with zero errors. Our ops team now focuses on strategy instead of data entry.',
      name: 'Priya Sharma',
      role: 'COO, LogiTrack Solutions',
      icon: Users
    },
    {
      quote: 'Exceptional technical expertise. The team understood our complex SAP workflows deeply and delivered automation that exceeded expectations.',
      name: 'Anil Kapoor',
      role: 'CTO, ManufacturePro',
      icon: Users
    }
  ]

  return (
    <div className="w-full relative overflow-x-hidden flex flex-col">
      
      {/* --- HERO SECTION --- */}
      <section className="relative w-full min-h-[calc(100vh-4rem)] flex items-center py-12 md:py-24 px-6 md:px-20 bg-zinc-50 dark:bg-zinc-950 text-zinc-950 dark:text-white overflow-hidden border-b border-zinc-200 dark:border-zinc-900">
        
        {/* Scoped CSS Animations for fadeSlideIn and marquee scrolling */}
        <style>{`
          @keyframes fadeSlideIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
          }
          @keyframes marquee {
            from { transform: translateX(0); }
            to { transform: translateX(-50%); }
          }
          .animate-fade-slide-in {
            animation: fadeSlideIn 0.8s ease-out forwards;
            opacity: 0;
          }
          .animate-marquee-scroller {
            animation: marquee 40s linear infinite;
          }
          .delay-100 { animation-delay: 0.1s; }
          .delay-200 { animation-delay: 0.2s; }
          .delay-300 { animation-delay: 0.3s; }
          .delay-400 { animation-delay: 0.4s; }
          .delay-500 { animation-delay: 0.5s; }
        `}</style>

        {/* Supabase Background Image Overlay (Behind Robot) */}
        <div 
          className="absolute inset-0 z-0 bg-[url(https://hoirqrkdgbmvpwutwuwj.supabase.co/storage/v1/object/public/assets/assets/a72ca2f3-9dd1-4fe4-84ba-fe86468a5237_3840w.webp?w=800&q=80)] bg-cover bg-center opacity-10 dark:opacity-30"
          style={{
            maskImage: "linear-gradient(180deg, transparent, black 0%, black 70%, transparent)",
            WebkitMaskImage: "linear-gradient(180deg, transparent, black 0%, black 70%, transparent)",
          }}
        />

        {/* Full-width Spline Scene Container (Robot sits floating in back on right, tracking mouse coordinates across page) */}
        <div className="absolute inset-y-0 right-0 w-[160%] h-full translate-x-[30%] z-0 pointer-events-auto hidden lg:block">
          <SplineScene 
            scene="https://prod.spline.design/kZDDjO5HuC9GJUM2/scene.splinecode"
            className="w-full h-full"
          />
        </div>

        <div className="mx-auto max-w-7xl w-full grid grid-cols-1 lg:grid-cols-12 gap-12 items-start z-10 pointer-events-none">
          
          {/* --- LEFT COLUMN --- */}
          <div className="lg:col-span-7 flex flex-col justify-center space-y-8 pt-8 text-left pointer-events-auto">
            
            {/* Pill Badge */}
            <div className="animate-fade-slide-in delay-100">
              <div className="inline-flex items-center gap-2 rounded-full border border-zinc-200 dark:border-white/10 bg-zinc-100 dark:bg-white/5 px-3 py-1.5 backdrop-blur-md transition-colors hover:bg-zinc-200/50 dark:hover:bg-white/10">
                <span className="text-[10px] sm:text-xs font-semibold uppercase tracking-wider text-zinc-600 dark:text-zinc-300 flex items-center gap-2">
                  Award-Winning Automation
                  <Star className="w-3.5 h-3.5 text-yellow-400 fill-yellow-400" />
                </span>
              </div>
            </div>

            {/* Headline */}
            <h1 
              className="animate-fade-slide-in delay-200 text-5xl sm:text-6xl lg:text-7xl xl:text-8xl font-medium tracking-tighter leading-[0.9]"
              style={{
                maskImage: "linear-gradient(180deg, black 0%, black 80%, transparent 100%)",
                WebkitMaskImage: "linear-gradient(180deg, black 0%, black 80%, transparent 100%)"
              }}
            >
              Transforming<br />
              Businesses with<br />
              <span className="text-gradient font-black">
                Intelligent Automation
              </span>
            </h1>

            {/* Description */}
            <p className="animate-fade-slide-in delay-300 max-w-xl text-base sm:text-lg text-zinc-600 dark:text-zinc-400 leading-relaxed">
              Deploy intelligent software robots that automate complex business processes, 
              eliminate errors, and accelerate digital transformation — at scale.
            </p>

            {/* CTA Buttons */}
            <div className="animate-fade-slide-in delay-400 flex flex-col sm:flex-row gap-4">
              <Link href="/services">
                <Button className="group bg-zinc-950 text-white hover:bg-zinc-800 dark:bg-white dark:text-zinc-950 dark:hover:bg-zinc-200 font-bold h-14 px-8 flex items-center justify-center gap-2 shadow-[0_4px_20px_rgba(194,122,0,0.15)] dark:shadow-[0_4px_20px_rgba(255,205,117,0.3)] rounded-full cursor-pointer transition-all hover:scale-[1.02] active:scale-[0.98]">
                  Explore Services
                  <ArrowRight className="w-4 h-4 transition-transform group-hover:translate-x-1" />
                </Button>
              </Link>
              <Link href="/contact">
                <Button variant="outline" className="border-zinc-300 dark:border-white/10 bg-white dark:bg-white/5 hover:bg-zinc-100 dark:hover:bg-white/10 text-zinc-900 dark:text-white font-bold h-14 px-8 rounded-full flex items-center justify-center gap-2 backdrop-blur-sm cursor-pointer">
                  <Play className="w-4 h-4 fill-current" />
                  Get Started
                </Button>
              </Link>
            </div>
          </div>

          {/* --- RIGHT COLUMN --- */}
          <div className="lg:col-span-5 h-[200px] lg:h-full relative pointer-events-none hidden lg:block" />
          
          {/* Mobile Spline Card */}
          <div className="block lg:hidden w-full h-[300px] relative rounded-3xl overflow-hidden border border-white/10 bg-black pointer-events-auto">
            <Spotlight
              className="-top-20 left-0"
              fill="white"
            />
            <SplineScene 
              scene="https://prod.spline.design/kZDDjO5HuC9GJUM2/scene.splinecode"
              className="w-full h-full"
            />
          </div>
        </div>
      </section>

      {/* --- TRUST & IMPACT SECTION --- */}
      <section className="w-full py-12 px-6 md:px-20 bg-zinc-50 dark:bg-zinc-950 text-zinc-950 dark:text-white relative z-10 border-b border-zinc-200 dark:border-zinc-900">
        <div className="mx-auto max-w-7xl">
          <div className="grid grid-cols-1 lg:grid-cols-12 gap-8 items-stretch">
            
            {/* Stats Card */}
            <div className="lg:col-span-7 relative overflow-hidden rounded-3xl glass-panel p-8 shadow-2xl">
              {/* Card Glow Effect */}
              <div className="absolute top-0 right-0 -mr-16 -mt-16 h-64 w-64 rounded-full bg-white/5 blur-3xl pointer-events-none" />

              <div className="relative z-10 text-left">
                <div className="flex items-center gap-4 mb-8">
                  <div className="flex h-12 w-12 items-center justify-center rounded-2xl bg-zinc-900/5 dark:bg-white/10 ring-1 ring-zinc-200 dark:ring-white/20">
                    <Target className="h-6 w-6 text-zinc-900 dark:text-white" />
                  </div>
                  <div>
                    <div className="text-3xl font-bold tracking-tight text-zinc-900 dark:text-white">300+</div>
                    <div className="text-sm text-zinc-600 dark:text-zinc-400">Projects Delivered</div>
                  </div>
                </div>

                {/* Progress Bar Section */}
                <div className="space-y-3 mb-8">
                  <div className="flex justify-between text-sm">
                    <span className="text-zinc-600 dark:text-zinc-400">Automation Success Rate</span>
                    <span className="text-zinc-900 dark:text-white font-medium">98%</span>
                  </div>
                  <div className="h-2 w-full overflow-hidden rounded-full bg-zinc-200 dark:bg-zinc-800/50">
                    <div className="h-full w-[98%] rounded-full bg-gradient-to-r from-[var(--neon-blue)] to-[var(--neon-purple)] animate-pulse" />
                  </div>
                </div>

                <div className="h-px w-full bg-zinc-200 dark:bg-white/10 mb-6" />

                {/* Mini Stats Grid */}
                <div className="grid grid-cols-3 gap-4 text-center">
                  <div className="flex flex-col items-center justify-center transition-transform hover:-translate-y-1 cursor-default">
                    <span className="text-xl font-bold text-zinc-900 dark:text-white sm:text-2xl">150+</span>
                    <span className="text-[10px] uppercase tracking-wider text-zinc-500 font-medium sm:text-xs">Clients</span>
                  </div>
                  <div className="w-px h-full bg-zinc-200 dark:bg-white/10 mx-auto" />
                  <div className="flex flex-col items-center justify-center transition-transform hover:-translate-y-1 cursor-default">
                    <span className="text-xl font-bold text-zinc-900 dark:text-white sm:text-2xl">24/7</span>
                    <span className="text-[10px] uppercase tracking-wider text-zinc-500 font-medium sm:text-xs">Support</span>
                  </div>
                  <div className="w-px h-full bg-zinc-200 dark:bg-white/10 mx-auto" />
                  <div className="flex flex-col items-center justify-center transition-transform hover:-translate-y-1 cursor-default">
                    <span className="text-xl font-bold text-zinc-900 dark:text-white sm:text-2xl">8+</span>
                    <span className="text-[10px] uppercase tracking-wider text-zinc-500 font-medium sm:text-xs">Years</span>
                  </div>
                </div>

                {/* Tag Pills */}
                <div className="mt-8 flex flex-wrap gap-2">
                  <div className="inline-flex items-center gap-1.5 rounded-full border border-white/10 bg-white/5 px-3 py-1 text-[10px] font-medium tracking-wide text-zinc-300">
                    <span className="relative flex h-2 w-2">
                      <span className="animate-ping absolute inline-flex h-full w-full rounded-full bg-green-400 opacity-75"></span>
                      <span className="relative inline-flex rounded-full h-2 w-2 bg-green-500"></span>
                    </span>
                    ACTIVE
                  </div>
                  <div className="inline-flex items-center gap-1.5 rounded-full border border-white/10 bg-white/5 px-3 py-1 text-[10px] font-medium tracking-wide text-zinc-300">
                    <Crown className="w-3 h-3 text-yellow-500" />
                    PREMIUM
                  </div>
                </div>
              </div>
            </div>

            {/* Marquee Card */}
            <div className="lg:col-span-5 relative overflow-hidden rounded-3xl glass-panel py-8 text-left flex flex-col justify-center min-h-[300px]">
              <h3 className="mb-6 px-8 text-sm font-medium text-zinc-600 dark:text-zinc-400">Trusted by Industry Leaders</h3>
              
              <div 
                className="relative flex overflow-hidden"
                style={{
                  maskImage: "linear-gradient(to right, transparent, black 20%, black 80%, transparent)",
                  WebkitMaskImage: "linear-gradient(to right, transparent, black 20%, black 80%, transparent)"
                }}
              >
                <div className="animate-marquee-scroller flex gap-12 whitespace-nowrap px-4">
                  {[
                    { name: "Acme Corp", icon: Hexagon },
                    { name: "Quantum", icon: Triangle },
                    { name: "Command+Z", icon: Command },
                    { name: "Phantom", icon: Ghost },
                    { name: "Ruby", icon: Gem },
                    { name: "Chipset", icon: Cpu }
                  ].concat(
                    { name: "Acme Corp", icon: Hexagon },
                    { name: "Quantum", icon: Triangle },
                    { name: "Command+Z", icon: Command },
                    { name: "Phantom", icon: Ghost },
                    { name: "Ruby", icon: Gem },
                    { name: "Chipset", icon: Cpu }
                  ).concat(
                    { name: "Acme Corp", icon: Hexagon },
                    { name: "Quantum", icon: Triangle },
                    { name: "Command+Z", icon: Command },
                    { name: "Phantom", icon: Ghost },
                    { name: "Ruby", icon: Gem },
                    { name: "Chipset", icon: Cpu }
                  ).map((client, i) => (
                    <div 
                      key={i}
                      className="flex items-center gap-2 opacity-60 dark:opacity-50 transition-all hover:opacity-100 hover:scale-105 cursor-default grayscale hover:grayscale-0"
                    >
                      <client.icon className="h-6 w-6 text-zinc-900 dark:text-white fill-current" />
                      <span className="text-lg font-bold text-zinc-900 dark:text-white tracking-tight">
                        {client.name}
                      </span>
                    </div>
                  ))}
                </div>
              </div>
            </div>

          </div>
        </div>
      </section>

      {/* --- STATS SECTION --- */}
      <section className="w-full py-10 md:py-14 px-6 md:px-20 bg-gradient-to-b from-[var(--background)] to-[var(--surface-light)]">
        <div className="mx-auto max-w-7xl">
          <div className="text-center space-y-4 max-w-3xl mx-auto">
            <motion.h2 
              initial={{ opacity: 0, y: 20 }}
              whileInView={{ opacity: 1, y: 0 }}
              viewport={{ once: true }}
              transition={{ duration: 0.6 }}
              className="text-3xl md:text-4xl font-extrabold tracking-tight text-gradient"
            >
              Results That Speak for Themselves
            </motion.h2>
            <motion.p 
              initial={{ opacity: 0, y: 20 }}
              whileInView={{ opacity: 1, y: 0 }}
              viewport={{ once: true }}
              transition={{ duration: 0.6, delay: 0.1 }}
              className="text-sm md:text-base text-[var(--text-secondary)]"
            >
              Trusted by enterprises across industries to automate, innovate, and grow.
            </motion.p>
          </div>

          <div className="mt-12 md:mt-16 grid grid-cols-2 lg:grid-cols-4 gap-6">
            <StatItem value={150} suffix="+" label="Happy Clients" delay={0.1} />
            <StatItem value={300} suffix="+" label="Projects Delivered" delay={0.2} />
            <StatItem value={98} suffix="%" label="Automation Success Rate" delay={0.3} />
            <StatItem value={8} suffix="+" label="Years of Excellence" delay={0.4} />
          </div>
        </div>
      </section>

      {/* --- SERVICES PREVIEW --- */}
      <section className="w-full py-12 md:py-16 px-6 md:px-20 bg-gradient-to-b from-[var(--surface-light)] to-[var(--background)]">
        <div className="mx-auto max-w-7xl">
          <div className="text-center space-y-4 max-w-3xl mx-auto">
            <div className="inline-block rounded-md border border-[var(--neon-blue)]/20 px-3 py-1 text-xs font-bold text-[var(--neon-blue)] uppercase tracking-wide">
              ⚙️ WHAT WE DO
            </div>
            <h2 className="text-3xl md:text-5xl font-extrabold leading-tight text-[var(--text-primary)]">
              Automation-First<br />Technology Services
            </h2>
            <p className="text-sm md:text-base text-[var(--text-secondary)]">
              From intelligent RPA bots to AI-driven applications — we build technology that works for you, not the other way around.
            </p>
          </div>

          <div className="mt-16 grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            {services.map((svc, i) => {
              const Icon = svc.icon
              return (
                <motion.div
                  key={svc.id}
                  initial={{ opacity: 0, y: 20 }}
                  whileInView={{ opacity: 1, y: 0 }}
                  viewport={{ once: true }}
                  transition={{ duration: 0.5, delay: 0.08 * i }}
                >
                  <Card className="p-8 h-full flex flex-col items-start glass-panel glass-panel-hover group">
                    <div 
                      className="p-3.5 rounded-xl mb-6 flex items-center justify-center bg-[var(--neon-blue)]/8 border border-[var(--neon-blue)]/20 group-hover:bg-white group-hover:text-zinc-950 transition-all duration-300"
                      style={{ color: svc.color }}
                    >
                      <Icon className="h-6 w-6 transition-colors duration-300" />
                    </div>
                    <h3 className="text-lg font-bold text-[var(--text-primary)] mb-3 group-hover:text-[var(--neon-blue)] transition-colors">
                      {svc.title}
                    </h3>
                    <p className="text-sm text-[var(--text-secondary)] leading-relaxed flex-1">
                      {svc.desc}
                    </p>
                  </Card>
                </motion.div>
              )
            })}
          </div>

          <div className="mt-12 text-center">
            <Link href="/services">
              <Button variant="outline" className="border-[var(--neon-blue)] text-[var(--neon-blue)] hover:bg-[var(--neon-blue)]/10 font-bold px-6 cursor-pointer">
                View All Services
                <ArrowRight className="h-4 w-4 ml-1.5" />
              </Button>
            </Link>
          </div>
        </div>
      </section>

      {/* --- WHY US SECTION --- */}
      <section className="w-full py-12 md:py-16 px-6 md:px-20 bg-gradient-to-b from-[var(--background)] to-[var(--surface-light)]">
        <div className="mx-auto max-w-7xl">
          <div className="text-center space-y-4 max-w-3xl mx-auto">
            <div className="inline-block rounded-md border border-[var(--neon-blue)]/20 px-3 py-1 text-xs font-bold text-[var(--neon-blue)] uppercase tracking-wide">
              ✅ WHY ROBOGENIUS
            </div>
            <h2 className="text-3xl md:text-5xl font-extrabold leading-tight text-[var(--text-primary)]">
              Why Industry Leaders<br />Choose Us
            </h2>
            <p className="text-sm md:text-base text-[var(--text-secondary)]">
              We combine deep automation expertise with cutting-edge technology to deliver solutions that scale with your ambitions.
            </p>
          </div>

          <div className="mt-16 grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            {reasons.map((item, i) => {
              const Icon = item.icon
              return (
                <motion.div
                  key={item.title}
                  initial={{ opacity: 0, y: 20 }}
                  whileInView={{ opacity: 1, y: 0 }}
                  viewport={{ once: true }}
                  transition={{ duration: 0.5, delay: 0.08 * i }}
                  className="flex gap-4 p-6 rounded-3xl glass-panel glass-panel-hover group"
                >
                  <div className="flex-shrink-0 h-10 w-10 rounded-lg flex items-center justify-center bg-[var(--neon-blue)]/10 text-[var(--neon-blue)] group-hover:bg-white group-hover:text-zinc-950 transition-all duration-300">
                    <Icon className="h-5 w-5" />
                  </div>
                  <div className="space-y-1.5">
                    <h3 className="text-base font-bold text-[var(--text-primary)]">
                      {item.title}
                    </h3>
                    <p className="text-xs text-[var(--text-secondary)] leading-relaxed">
                      {item.desc}
                    </p>
                  </div>
                </motion.div>
              )
            })}
          </div>
        </div>
      </section>

      {/* --- TESTIMONIALS SECTION --- */}
      <section className="w-full py-12 md:py-16 px-6 md:px-20 bg-gradient-to-b from-[var(--surface-light)] to-[var(--background)]">
        <div className="mx-auto max-w-7xl">
          <div className="text-center space-y-4 max-w-3xl mx-auto">
            <div className="inline-block rounded-md border border-[var(--neon-blue)]/20 px-3 py-1 text-xs font-bold text-[var(--neon-blue)] uppercase tracking-wide">
              💬 CLIENT STORIES
            </div>
            <h2 className="text-3xl md:text-5xl font-extrabold leading-tight text-[var(--text-primary)]">
              Trusted by Industry<br />Leaders Across India
            </h2>
            <p className="text-sm md:text-base text-[var(--text-secondary)]">
              Real results from real businesses that chose intelligent automation.
            </p>
          </div>

          <div className="mt-16 grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            {testimonials.map((item, i) => (
              <motion.div
                key={item.name}
                initial={{ opacity: 0, y: 20 }}
                whileInView={{ opacity: 1, y: 0 }}
                viewport={{ once: true }}
                transition={{ duration: 0.5, delay: 0.1 * i }}
                className="flex flex-col p-8 rounded-3xl glass-panel glass-panel-hover group"
              >
                <div className="text-gradient text-5xl font-black leading-none h-6 select-none">
                  “
                </div>
                {/* Stars */}
                <div className="flex gap-0.5 mt-2 mb-4">
                  {Array.from({ length: 5 }).map((_, idx) => (
                    <Star key={idx} className="h-4.5 w-4.5 fill-amber-400 text-amber-400" />
                  ))}
                </div>
                <p className="text-sm text-[var(--text-secondary)] leading-relaxed flex-1 italic">
                  {item.quote}
                </p>
                <div className="mt-6 flex items-center gap-3 pt-4 border-t border-[var(--border)]/40">
                  <div className="h-10 w-10 rounded-full bg-gradient-to-br from-[var(--neon-blue)]/20 to-[var(--neon-purple)]/15 flex items-center justify-center text-[var(--neon-blue)]">
                    <item.icon className="h-5 w-5" />
                  </div>
                  <div>
                    <h4 className="text-sm font-bold text-[var(--text-primary)]">
                      {item.name}
                    </h4>
                    <p className="text-xs text-[var(--text-muted)]">
                      {item.role}
                    </p>
                  </div>
                </div>
              </motion.div>
            ))}
          </div>
        </div>
      </section>

      {/* --- CTA SECTION --- */}
      <section className="w-full py-10 px-6 md:px-20 relative z-10">
        <div className="mx-auto max-w-5xl rounded-3xl glass-panel p-8 md:p-16 relative overflow-hidden shadow-2xl border-t-2 border-t-[var(--neon-blue)]/40 hover:bg-white/[0.04] dark:hover:bg-white/[0.04] transition-all duration-300 group">
          {/* Background Grid */}
          <div className="absolute inset-0 opacity-[0.03] bg-[linear-gradient(to_right,#808080_1px,transparent_1px),linear-gradient(to_bottom,#808080_1px,transparent_1px)] bg-[size:30px_30px] pointer-events-none" />
          
          <div className="relative z-10 flex flex-col lg:flex-row items-center justify-between gap-10">
            <div className="space-y-4 max-w-xl text-left">
              <h2 className="text-3xl md:text-4xl font-extrabold text-[var(--text-primary)] leading-tight">
                Ready to Automate<br />Your Business?
              </h2>
              <p className="text-sm md:text-base text-[var(--text-secondary)] leading-relaxed">
                Schedule a free automation assessment with our RPA experts and discover how much time and cost you can save.
              </p>
            </div>
            <div className="flex flex-col gap-3.5 w-full sm:w-56 shrink-0">
              <Link href="/contact">
                <Button className="w-full bg-zinc-950 text-white hover:bg-zinc-800 dark:bg-white dark:text-zinc-950 dark:hover:bg-zinc-200 font-bold h-12 flex items-center justify-center gap-2 rounded-full cursor-pointer transition-all hover:scale-[1.02] active:scale-[0.98] shadow-[0_4px_16px_rgba(194,122,0,0.15)] dark:shadow-[0_4px_16px_rgba(255,205,117,0.3)]">
                  Get Free Assessment
                  <Rocket className="h-4 w-4" />
                </Button>
              </Link>
              <Link href="/services">
                <Button variant="ghost" className="w-full border border-zinc-200 dark:border-transparent text-zinc-900 dark:text-[var(--text-primary)] hover:bg-[var(--neon-blue)]/10 h-12 font-bold cursor-pointer">
                  View Case Studies
                  <ArrowRight className="h-4 w-4 ml-1.5" />
                </Button>
              </Link>
            </div>
          </div>
        </div>
      </section>

    </div>
  )
}
