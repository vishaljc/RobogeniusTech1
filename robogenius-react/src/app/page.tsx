'use client'

import { useState, useEffect, useRef } from 'react'
import Link from 'next/link'
import Image from 'next/image'
import dynamic from 'next/dynamic'
import { motion, useInView } from 'framer-motion'
import { 
  Bot, Rocket, ArrowRight, ShieldCheck, Zap, Award, 
  Users, CheckCircle2, Star, TrendingUp, Cpu, Network, Clock,
  Play, Target, Crown, Hexagon, Triangle, Command, Ghost, Gem
} from 'lucide-react'
import { Button } from '@/components/ui/button'
import { Card } from '@/components/ui/card'
import { Spotlight } from '@/components/ui/spotlight'

// Lazy load heavy WebGL component, disable server-side rendering
const SplineScene = dynamic(() => import('@/components/ui/splite').then((mod) => mod.SplineScene), {
  ssr: false,
  loading: () => null
})

// --- Stats Counter ---
function StatItem({ value, suffix, label, delay }: { value: number; suffix: string; label: string; delay: number }) {
  const [count, setCount] = useState(0)
  const ref = useRef<HTMLDivElement>(null)
  const isInView = useInView(ref, { once: true, margin: "-100px" })

  useEffect(() => {
    if (!isInView) return

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
  }, [isInView, value, delay])

  return (
    <motion.div
      ref={ref}
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
  const [robotLoaded, setRobotLoaded] = useState(false)
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



  return (
    <div className="w-full relative overflow-x-hidden flex flex-col">
      
      {/* --- HERO SECTION --- */}
      <section className="relative w-full min-h-[calc(100vh-4rem)] flex items-center py-12 md:py-24 px-6 md:px-20 bg-zinc-50 dark:bg-zinc-950 text-zinc-950 dark:text-white overflow-hidden border-b border-stone-200 dark:border-stone-900">
        
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
            animation: marquee 45s linear infinite;
          }
          .delay-100 { animation-delay: 0.1s; }
          .delay-200 { animation-delay: 0.2s; }
          .delay-300 { animation-delay: 0.3s; }
          .delay-400 { animation-delay: 0.4s; }
          .delay-500 { animation-delay: 0.5s; }
        `}</style>

        {/* Supabase Background Image Overlay (Behind Robot) */}
        <div 
          className="absolute inset-0 z-0 opacity-[0.04] dark:opacity-[0.15] pointer-events-none"
          style={{
            maskImage: "linear-gradient(180deg, transparent, black 15%, black 75%, transparent)",
            WebkitMaskImage: "linear-gradient(180deg, transparent, black 15%, black 75%, transparent)",
          }}
        >
          <Image
            src="https://hoirqrkdgbmvpwutwuwj.supabase.co/storage/v1/object/public/assets/assets/a72ca2f3-9dd1-4fe4-84ba-fe86468a5237_3840w.webp"
            alt="RoboGenius Background Glow"
            fill
            sizes="100vw"
            priority
            className="object-cover object-center"
          />
        </div>

        {/* Full-width Spline Scene Container (Robot sits floating in back on right) */}
        <div className={`absolute inset-y-0 right-0 w-[150%] h-full translate-x-[32%] z-0 pointer-events-none hidden lg:block transition-opacity duration-1000 ${
          robotLoaded ? 'opacity-100' : 'opacity-0'
        }`}>
          <SplineScene 
            scene="https://prod.spline.design/kZDDjO5HuC9GJUM2/scene.splinecode"
            className="w-full h-full"
            onLoad={() => setRobotLoaded(true)}
          />
        </div>

        <div className="mx-auto max-w-7xl w-full grid grid-cols-1 lg:grid-cols-12 gap-12 items-start z-10 pointer-events-none">
          
          {/* --- LEFT COLUMN --- */}
          <div 
            className={`transition-all duration-1000 ease-in-out flex flex-col justify-center space-y-8 pt-8 pointer-events-auto ${
              robotLoaded 
                ? 'lg:col-span-7 text-left items-start' 
                : 'lg:col-span-12 text-center items-center max-w-3xl mx-auto'
            }`}
          >
            
            {/* Pill Badge */}
            <div className="animate-fade-slide-in delay-100">
              <div className="inline-flex items-center gap-2 rounded-full border border-stone-200 dark:border-stone-800 bg-white/60 dark:bg-stone-900/60 px-3.5 py-1.5 backdrop-blur-md transition-colors hover:border-amber-500/30">
                <span className="text-[10px] sm:text-xs font-semibold uppercase tracking-[0.08em] text-stone-600 dark:text-stone-300 flex items-center gap-2">
                  Award-Winning Automation LLP
                  <Star className="w-3.5 h-3.5 text-amber-500 fill-amber-500" />
                </span>
              </div>
            </div>

            {/* Headline */}
            <h1 
              className="animate-fade-slide-in delay-200 text-5xl sm:text-6xl lg:text-7xl xl:text-8xl font-medium font-heading tracking-tight leading-[0.95] text-wrap"
            >
              Transforming<br />
              Businesses with<br />
              <span className="text-gradient font-black">
                Intelligent Automation
              </span>
            </h1>

            {/* Description */}
            <p className={`animate-fade-slide-in delay-300 max-w-xl text-base sm:text-lg text-stone-600 dark:text-stone-400 leading-relaxed text-wrap transition-all duration-1000 ${
              robotLoaded ? 'text-left' : 'text-center'
            }`}>
              Deploy intelligent software robots that automate complex business processes, 
              eliminate errors, and accelerate digital transformation — at scale.
            </p>

            {/* CTA Buttons */}
            <div className={`animate-fade-slide-in delay-400 flex flex-col sm:flex-row gap-4 transition-all duration-1000 ${
              robotLoaded ? 'justify-start' : 'justify-center'
            }`}>
              <Link href="/services">
                <Button className="group bg-[var(--foreground)] text-[var(--background)] hover:bg-[var(--foreground)]/90 font-bold h-14 px-8 flex items-center justify-center gap-2 shadow-[0_4px_20px_rgba(217,119,6,0.18)] rounded-full cursor-pointer transition-all hover:scale-[1.02] active:scale-[0.98]">
                  Explore Services
                  <ArrowRight className="w-4 h-4 transition-transform group-hover:translate-x-1" />
                </Button>
              </Link>
              <Link href="/contact">
                <Button variant="outline" className="border-stone-300 dark:border-stone-800 bg-white/60 dark:bg-stone-900/40 hover:bg-stone-100 dark:hover:bg-stone-900/60 text-stone-900 dark:text-white font-bold h-14 px-8 rounded-full flex items-center justify-center gap-2 backdrop-blur-sm cursor-pointer transition-all hover:scale-[1.02] active:scale-[0.98]">
                  <Play className="w-4 h-4 fill-current" />
                  Get Started
                </Button>
              </Link>
            </div>
          </div>

          {/* --- RIGHT COLUMN --- */}
          <div className="lg:col-span-5 h-[200px] lg:h-full relative pointer-events-none hidden lg:block" />
          
          {/* Mobile Spline Card */}
          <div className="block lg:hidden w-full h-[300px] relative rounded-3xl overflow-hidden border border-stone-200 dark:border-stone-800 bg-stone-100 dark:bg-stone-950 pointer-events-auto">
            <Spotlight
              className="-top-20 left-0"
              fill="var(--neon-blue)"
            />
            <SplineScene 
              scene="https://prod.spline.design/kZDDjO5HuC9GJUM2/scene.splinecode"
              className="w-full h-full"
              onLoad={() => setRobotLoaded(true)}
            />
          </div>
        </div>
      </section>

      {/* --- TRUST & IMPACT SECTION (NO CARDS, CUSTOM MARQUEE AND Clean Borders) --- */}
      <section className="w-full py-16 px-6 md:px-20 bg-zinc-50 dark:bg-zinc-950 text-zinc-950 dark:text-white relative z-10 border-b border-stone-200 dark:border-stone-900">
        <div className="mx-auto max-w-7xl">
          {/* Stat Numbers Grid */}
          <div className="grid grid-cols-1 md:grid-cols-3 gap-8 items-center justify-between py-6 border-b border-stone-200 dark:border-stone-900">
            <div className="text-left space-y-2">
              <span className="text-[10px] font-black uppercase tracking-[0.08em] text-stone-500">EXPERIENCE</span>
              <div className="text-4xl md:text-5xl font-black font-heading text-gradient">100+</div>
              <p className="text-sm text-stone-600 dark:text-stone-400">Successful automation projects deployed worldwide</p>
            </div>
            <div className="text-left space-y-2 md:border-x md:border-stone-200 md:dark:border-stone-900 md:px-8">
              <span className="text-[10px] font-black uppercase tracking-[0.08em] text-stone-500">ACCURACY</span>
              <div className="text-4xl md:text-5xl font-black font-heading text-gradient">98%</div>
              <p className="text-sm text-stone-600 dark:text-stone-400">Success rate in Robotic Process Automation execution</p>
            </div>
            <div className="text-left space-y-2 md:pl-8">
              <span className="text-[10px] font-black uppercase tracking-[0.08em] text-stone-500">AVAILABILITY</span>
              <div className="text-4xl md:text-5xl font-black font-heading text-gradient">24/7</div>
              <p className="text-sm text-stone-600 dark:text-stone-400">Uninterrupted operation support and error monitoring</p>
            </div>
          </div>

          {/* Marquee Scroller */}
          <div className="pt-10 text-left">
            <h3 className="text-xs font-bold uppercase tracking-[0.08em] text-stone-500 mb-8">Trusted by Industry Leaders</h3>
            <div 
              className="relative flex overflow-hidden py-3"
              style={{
                maskImage: "linear-gradient(to right, transparent, black 15%, black 85%, transparent)",
                WebkitMaskImage: "linear-gradient(to right, transparent, black 15%, black 85%, transparent)"
              }}
            >
              <div className="animate-marquee-scroller flex gap-16 whitespace-nowrap">
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
                    className="flex items-center gap-3 opacity-50 dark:opacity-40 transition-all hover:opacity-100 hover:scale-105 cursor-default grayscale hover:grayscale-0"
                  >
                    <client.icon className="h-5 w-5 text-stone-900 dark:text-white" />
                    <span className="text-base font-bold tracking-tight text-stone-900 dark:text-white">
                      {client.name}
                    </span>
                  </div>
                ))}
              </div>
            </div>
          </div>
        </div>
      </section>

      {/* --- STATS COUNT ANIMATION SECTION --- */}
      <section className="w-full py-16 md:py-20 bg-gradient-to-b from-[var(--background)] to-[var(--surface-light)]">
        <div className="mx-auto max-w-7xl">
          <div className="text-center space-y-4 max-w-3xl mx-auto">
            <motion.h2 
              initial={{ opacity: 0, y: 20 }}
              whileInView={{ opacity: 1, y: 0 }}
              viewport={{ once: true }}
              transition={{ duration: 0.6 }}
              className="text-3xl md:text-5xl font-extrabold font-heading tracking-tight text-gradient"
            >
              Proven Track Record of Excellence
            </motion.h2>
            <motion.p 
              initial={{ opacity: 0, y: 20 }}
              whileInView={{ opacity: 1, y: 0 }}
              viewport={{ once: true }}
              transition={{ duration: 0.6, delay: 0.1 }}
              className="text-sm md:text-base text-stone-600 dark:text-stone-400"
            >
              Providing RPA, AI integration, and digital services that scale operations and eliminate manual workflow bottlenecks.
            </motion.p>
          </div>

          <div className="mt-16 grid grid-cols-2 lg:grid-cols-4 gap-6">
            <StatItem value={50} suffix="+" label="Happy Clients" delay={0.1} />
            <StatItem value={100} suffix="+" label="Projects Delivered" delay={0.2} />
            <StatItem value={98} suffix="%" label="Automation Success Rate" delay={0.3} />
            <StatItem value={5} suffix="+" label="Years of Excellence" delay={0.4} />
          </div>
        </div>
      </section>

      {/* --- SERVICES PREVIEW (Warm Glass Cards with shadow/glows) --- */}
      <section className="w-full py-16 md:py-24 px-6 md:px-20 bg-gradient-to-b from-[var(--surface-light)] to-[var(--background)]">
        <div className="mx-auto max-w-7xl">
          <div className="text-center space-y-4 max-w-3xl mx-auto">
            <div className="inline-flex items-center gap-2 rounded-full border border-[var(--primary)]/20 bg-[var(--primary)]/5 px-3 py-1">
              <span className="text-[10px] sm:text-xs font-bold tracking-[0.08em] text-[var(--neon-blue)] uppercase">
                WHAT WE DO
              </span>
            </div>
            <h2 className="text-3xl md:text-5xl font-extrabold font-heading leading-tight text-[var(--text-primary)]">
              Automation-First<br />Technology Services
            </h2>
            <p className="text-sm md:text-base text-stone-600 dark:text-stone-400">
              From intelligent RPA bots to custom web and mobile platforms — we design and develop technology that empowers your team.
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
                  <Card className="p-8 h-full flex flex-col items-start glass-panel glass-panel-hover group cursor-pointer">
                    <div 
                      className="p-3.5 rounded-xl mb-6 flex items-center justify-center bg-[var(--primary)]/8 border border-[var(--primary)]/20 group-hover:bg-button-gradient group-hover:text-white transition-all duration-300"
                      style={{ color: 'var(--neon-blue)' }}
                    >
                      <Icon className="h-6 w-6 transition-colors duration-300" />
                    </div>
                    <h3 className="text-lg font-bold text-[var(--text-primary)] mb-3 group-hover:text-[var(--neon-blue)] transition-colors">
                      {svc.title}
                    </h3>
                    <p className="text-sm text-stone-600 dark:text-stone-400 leading-relaxed flex-1">
                      {svc.desc}
                    </p>
                  </Card>
                </motion.div>
              )
            })}
          </div>

          <div className="mt-12 text-center">
            <Link href="/services">
              <Button variant="outline" className="border-stone-300 dark:border-stone-800 text-[var(--neon-blue)] hover:bg-[var(--primary)]/10 font-bold px-6 cursor-pointer">
                View All Services
                <ArrowRight className="h-4 w-4 ml-1.5" />
              </Button>
            </Link>
          </div>
        </div>
      </section>

      {/* --- WHY US SECTION (NO CARDS, CLEAN EDITORIAL LIST) --- */}
      <section className="w-full py-16 md:py-24 px-6 md:px-20 bg-gradient-to-b from-[var(--background)] to-[var(--surface-light)]">
        <div className="mx-auto max-w-7xl">
          <div className="text-center space-y-4 max-w-3xl mx-auto mb-16">
            <div className="inline-flex items-center gap-2 rounded-full border border-[var(--primary)]/20 bg-[var(--primary)]/5 px-3 py-1">
              <span className="text-[10px] sm:text-xs font-bold tracking-[0.08em] text-[var(--neon-blue)] uppercase">
                WHY ROBOGENIUS
              </span>
            </div>
            <h2 className="text-3xl md:text-5xl font-extrabold font-heading leading-tight text-[var(--text-primary)]">
              Why Industry Leaders<br />Choose Us
            </h2>
            <p className="text-sm md:text-base text-stone-600 dark:text-stone-400">
              We combine robust automation engineering with a commitment to rapid delivery and audit-ready security.
            </p>
          </div>

          {/* Clean Editorial Layout - Replacing Cards Grid */}
          <div className="mt-12 grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-y-12 gap-x-8">
            {reasons.map((item, i) => {
              const Icon = item.icon
              return (
                <motion.div
                  key={item.title}
                  initial={{ opacity: 0, y: 20 }}
                  whileInView={{ opacity: 1, y: 0 }}
                  viewport={{ once: true }}
                  transition={{ duration: 0.5, delay: 0.08 * i }}
                  className="flex flex-col text-left space-y-4 group"
                >
                  <div className="h-10 w-10 rounded-lg flex items-center justify-center bg-[var(--primary)]/8 text-[var(--neon-blue)] group-hover:bg-button-gradient group-hover:text-white transition-all duration-300 border border-[var(--primary)]/10">
                    <Icon className="h-5 w-5" />
                  </div>
                  <div className="space-y-2">
                    <h3 className="text-lg font-bold text-[var(--text-primary)] group-hover:text-[var(--neon-blue)] transition-colors">
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

      {/* --- CTA SECTION (Polished Amber/Glow Glass Panel) --- */}
      <section className="w-full py-16 px-6 md:px-20 relative z-10">
        <div className="mx-auto max-w-5xl rounded-3xl glass-panel p-8 md:p-16 relative overflow-hidden shadow-2xl border-t border-t-[var(--primary)]/30 hover:bg-white/[0.06] dark:hover:bg-white/[0.04] transition-all duration-300 group">
          {/* Background Grid */}
          <div className="absolute inset-0 opacity-[0.02] bg-[linear-gradient(to_right,#808080_1px,transparent_1px),linear-gradient(to_bottom,#808080_1px,transparent_1px)] bg-[size:30px_30px] pointer-events-none" />
          <div className="absolute -right-32 -bottom-32 h-96 w-96 rounded-full bg-[var(--primary)]/5 blur-3xl pointer-events-none group-hover:bg-[var(--primary)]/10 transition-all duration-500" />
          
          <div className="relative z-10 flex flex-col lg:flex-row items-center justify-between gap-10">
            <div className="space-y-4 max-w-xl text-left">
              <h2 className="text-3xl md:text-4xl font-extrabold font-heading text-[var(--text-primary)] leading-tight">
                Ready to Automate<br />Your Business?
              </h2>
              <p className="text-sm md:text-base text-stone-600 dark:text-stone-400 leading-relaxed">
                Schedule a free automation assessment with our RPA experts and discover how much time and cost you can save.
              </p>
            </div>
            <div className="flex flex-col gap-3.5 w-full sm:w-56 shrink-0">
              <Link href="/contact">
                <Button className="w-full bg-[var(--foreground)] text-[var(--background)] hover:bg-[var(--foreground)]/90 font-bold h-12 flex items-center justify-center gap-2 rounded-full cursor-pointer transition-all hover:scale-[1.02] active:scale-[0.98] shadow-[0_4px_16px_rgba(217,119,6,0.25)]">
                  Get Free Assessment
                  <Rocket className="h-4 w-4" />
                </Button>
              </Link>
              <Link href="/services">
                <Button variant="ghost" className="w-full border border-stone-200 dark:border-stone-800 text-stone-900 dark:text-[var(--text-primary)] hover:bg-[var(--primary)]/10 h-12 font-bold cursor-pointer">
                  View All Services
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
