'use client'

import { motion } from 'framer-motion'
import { 
  Bot, Rocket, Cpu, Network, Award, CheckCircle2, ArrowRight,
  Search, ShieldAlert, CpuIcon, Layers, Settings2, PlayCircle
} from 'lucide-react'
import { Button } from '@/components/ui/button'
import { Card } from '@/components/ui/card'

export default function Services() {
  const services = [
    {
      id: 'rpa',
      title: 'Robotic Process Automation',
      shortDescription: 'Automate repetitive tasks with intelligent software robots that work 24/7.',
      fullDescription: 'Our RPA solutions deploy intelligent software bots that replicate human actions across digital systems. From data entry to complex workflows, we automate end-to-end processes with precision, speed, and zero errors — freeing your workforce for high-value strategic work.',
      icon: Cpu,
      color: 'var(--neon-blue)',
      benefits: [
        '70% reduction in operational costs',
        '10x faster process execution',
        '99.9% accuracy rate',
        '24/7 uninterrupted operation',
        'Seamless legacy system integration',
        'Rapid ROI within 3–6 months',
      ],
      isHighlight: true,
    },
    {
      id: 'ai',
      title: 'AI & Machine Learning',
      shortDescription: 'Harness the power of AI to derive insights, predict outcomes, and automate decisions.',
      fullDescription: 'We build custom AI and ML models tailored to your industry. From predictive analytics to natural language processing, our intelligent systems learn from data and continuously improve performance.',
      icon: Bot,
      color: 'var(--neon-purple)',
      benefits: [
        'Predictive analytics dashboards',
        'NLP and sentiment analysis',
        'Computer vision solutions',
        'Anomaly detection systems',
      ],
    },
    {
      id: 'mobile',
      title: 'Mobile App Development',
      shortDescription: 'Native and cross-platform mobile apps for Android & iOS with cutting-edge UX.',
      fullDescription: 'From concept to deployment, we build high-performance mobile applications using Flutter (cross-platform) and native Swift/Kotlin. Our apps are built for scale, speed, and superior user experience.',
      icon: Rocket,
      color: 'var(--neon-cyan)',
      benefits: [
        'Android & iOS from one codebase',
        'Flutter / React Native',
        'Native Swift & Kotlin',
        'Fintech, healthtech, enterprise apps',
      ],
    },
    {
      id: 'web',
      title: 'Web Development',
      shortDescription: 'Scalable, high-performance web applications built on modern tech stacks.',
      fullDescription: 'We architect and develop enterprise-grade web platforms using React, Flutter Web, Node.js, and cloud-native infrastructure. Every product we ship is optimised for performance, security, and scale.',
      icon: Network,
      color: 'var(--neon-blue)',
      benefits: [
        'React / Flutter Web / Next.js',
        'REST & GraphQL APIs',
        'Cloud deployment (AWS, GCP, Azure)',
        'SEO & Core Web Vitals optimised',
      ],
    },
    {
      id: 'uiux',
      title: 'UI/UX Design',
      shortDescription: 'Intuitive, research-driven design systems that delight users and drive conversion.',
      fullDescription: 'Our design team crafts user-centric digital experiences backed by research and data. We build comprehensive design systems, prototypes, and pixel-perfect interfaces that reflect your brand.',
      icon: Award,
      color: 'var(--neon-purple)',
      benefits: [
        'User research & wireframing',
        'Figma design systems',
        'Interactive prototyping',
        'Accessibility-first design',
      ],
    },
  ]

  const processSteps = [
    {
      step: '01',
      title: 'Discovery',
      icon: Search,
      desc: 'We analyse your current processes and identify high-ROI automation opportunities.'
    },
    {
      step: '02',
      title: 'Design',
      icon: Layers,
      desc: 'Our architects design the automation workflow, bot logic, and integration blueprint.'
    },
    {
      step: '03',
      title: 'Build',
      icon: Settings2,
      desc: 'Expert developers build, configure, and test your RPA bots in a sandbox environment.'
    },
    {
      step: '04',
      title: 'Deploy',
      icon: Rocket,
      desc: 'Go live with monitoring, alerting, and SLA-backed support from day one.'
    }
  ]

  const rpaNodes = [
    { label: 'Trigger', x: '50%', y: '10%' },
    { label: 'Bot', x: '90%', y: '35%' },
    { label: 'Process', x: '90%', y: '65%' },
    { label: 'Output', x: '50%', y: '90%' },
    { label: 'Analytics', x: '10%', y: '65%' },
    { label: 'Monitor', x: '10%', y: '35%' },
  ]

  return (
    <div className="w-full relative overflow-x-hidden flex flex-col">
      
      {/* --- HERO SECTION --- */}
      <section className="relative w-full py-16 md:py-24 px-6 md:px-20 bg-hero-gradient border-b border-[var(--border)]">
        <div className="absolute top-[-10%] left-[-10%] h-[350px] w-[350px] rounded-full bg-[var(--neon-blue)]/8 blur-[100px] pointer-events-none" />
        <div className="absolute bottom-[10%] right-[-10%] h-[350px] w-[350px] rounded-full bg-[var(--neon-purple)]/8 blur-[100px] pointer-events-none" />

        <div className="mx-auto max-w-4xl text-center space-y-6 z-10">
          <motion.div 
            initial={{ opacity: 0, scale: 0.95 }}
            animate={{ opacity: 1, scale: 1 }}
            className="inline-flex items-center gap-2.5 rounded-full border border-[var(--neon-blue)]/30 bg-gradient-to-r from-[var(--neon-blue)]/12 to-[var(--neon-purple)]/12 px-4 py-1.5 mx-auto"
          >
            <span className="text-xs font-bold tracking-wide text-[var(--neon-blue)] uppercase">
              ⚙️ OUR SERVICES
            </span>
          </motion.div>

          <motion.h1 
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.6, delay: 0.1 }}
            className="text-4xl md:text-6xl font-black tracking-tight leading-[1.1] text-[var(--text-primary)]"
          >
            Complete Digital<br />
            <span className="text-gradient">
              Transformation Suite
            </span>
          </motion.h1>

          <motion.p 
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.6, delay: 0.2 }}
            className="text-base md:text-lg leading-relaxed text-[var(--text-secondary)] max-w-2xl mx-auto"
          >
            From robotic process automation to full-stack development — we provide end-to-end technology services that digitise, automate, and accelerate your business.
          </motion.p>
        </div>
      </section>

      {/* --- FEATURED RPA SERVICE SECTION --- */}
      <section className="w-full py-12 md:py-16 px-6 md:px-20 bg-[var(--background)]">
        <div className="mx-auto max-w-7xl">
          <div className="rounded-3xl glass-panel p-8 md:p-16 relative overflow-hidden shadow-2xl border-t-2 border-t-[var(--neon-blue)]/40 hover:bg-white/[0.04] dark:hover:bg-white/[0.04] transition-all duration-300">
            <div className="absolute inset-0 opacity-[0.02] bg-[linear-gradient(to_right,#808080_1px,transparent_1px),linear-gradient(to_bottom,#808080_1px,transparent_1px)] bg-[size:40px_40px] pointer-events-none" />
            
            <div className="grid grid-cols-1 lg:grid-cols-12 gap-12 items-center relative z-10">
              
              {/* Featured Left Content */}
              <div className="lg:col-span-7 space-y-6 text-left">
                <div className="inline-flex items-center gap-2.5 rounded-md border border-[var(--neon-blue)]/30 bg-[var(--neon-blue)]/15 px-3 py-1">
                  <span className="text-xs font-bold tracking-widest text-[var(--neon-blue)] uppercase">
                    🌟 FEATURED SERVICE
                  </span>
                </div>

                <h2 className="text-3xl md:text-4xl font-extrabold text-white leading-tight">
                  Robotic Process Automation
                </h2>

                <p className="text-sm md:text-base leading-relaxed text-zinc-400">
                  Our RPA solutions deploy intelligent software bots that replicate human actions across digital systems. From data entry to complex workflows, we automate end-to-end processes with precision, speed, and zero errors — freeing your workforce for high-value strategic work.
                </p>

                <div className="grid grid-cols-1 sm:grid-cols-2 gap-3 pt-2">
                  {services[0].benefits.map((b) => (
                    <div key={b} className="flex items-center gap-2 text-xs text-zinc-300">
                      <CheckCircle2 className="h-4.5 w-4.5 text-[var(--neon-cyan)] shrink-0" />
                      <span>{b}</span>
                    </div>
                  ))}
                </div>

                <div className="pt-4">
                  <Button className="bg-white text-zinc-950 hover:bg-zinc-200 font-bold h-11 px-6 rounded-full flex items-center gap-2 transition-all hover:scale-[1.02] active:scale-[0.98] shadow-[0_4px_12px_rgba(255,205,117,0.3)] cursor-pointer">
                    Explore RPA Solutions
                    <ArrowRight className="h-4 w-4" />
                  </Button>
                </div>
              </div>

              {/* Featured Right Visual Flow */}
              <div className="lg:col-span-5 h-[360px] relative rounded-3xl glass-panel flex items-center justify-center p-6 select-none">
                {/* SVG Connections */}
                <svg className="absolute inset-0 w-full h-full pointer-events-none" style={{ stroke: 'rgba(255,205,117,0.2)', strokeWidth: 1.5 }}>
                  <line x1="50%" y1="50%" x2="50%" y2="10%" />
                  <line x1="50%" y1="50%" x2="90%" y2="35%" />
                  <line x1="50%" y1="50%" x2="90%" y2="65%" />
                  <line x1="50%" y1="50%" x2="50%" y2="90%" />
                  <line x1="50%" y1="50%" x2="10%" y2="65%" />
                  <line x1="50%" y1="50%" x2="10%" y2="35%" />

                  {/* Ring lines */}
                  <polygon points="50%,10% 90%,35% 90%,65% 50%,90% 10%,65% 10%,35%" fill="none" stroke="rgba(255,205,117,0.25)" />
                </svg>

                {/* Central Hub */}
                <div className="h-[76px] w-[76px] rounded-full bg-gradient-to-br from-[var(--neon-blue)] to-[var(--neon-purple)] flex flex-col items-center justify-center text-white border border-[var(--neon-blue)]/50 shadow-[0_0_24px_rgba(255,205,117,0.4)] z-10 text-center">
                  <span className="text-[11px] font-black leading-none">RPA</span>
                  <span className="text-[11px] font-black leading-none">Core</span>
                </div>

                {/* Flow Nodes */}
                {rpaNodes.map((n) => (
                  <div 
                    key={n.label}
                    className="absolute h-14 w-14 rounded-full glass-panel flex flex-col items-center justify-center z-10 transition-all duration-300 hover:scale-110 border-[var(--neon-blue)]/30"
                    style={{ left: n.x, top: n.y, transform: 'translate(-50%, -50%)' }}
                  >
                    <span className="text-xs font-bold text-zinc-300">{n.label}</span>
                  </div>
                ))}
              </div>

            </div>
          </div>
        </div>
      </section>

      {/* --- ALL SERVICES Alternating List --- */}
      <section className="w-full py-12 md:py-16 px-6 md:px-20 bg-gradient-to-b from-[var(--background)] to-[var(--surface-light)] border-b border-[var(--border)]">
        <div className="mx-auto max-w-7xl">
          <div className="text-center space-y-4 max-w-3xl mx-auto mb-16">
            <div className="inline-block rounded-md border border-[var(--neon-blue)]/20 px-3 py-1 text-xs font-bold text-[var(--neon-blue)] uppercase tracking-wide">
              🛠 ALL SERVICES
            </div>
            <h2 className="text-3xl md:text-5xl font-extrabold leading-tight text-[var(--text-primary)]">
              Everything You Need<br />to Digitise & Automate
            </h2>
            <p className="text-sm md:text-base text-[var(--text-secondary)]">
              A comprehensive portfolio of technology services designed for the digital-first enterprise.
            </p>
          </div>

          <div className="space-y-12">
            {services.map((svc, index) => {
              const Icon = svc.icon
              const isEven = index % 2 === 0
              return (
                <motion.div
                  key={svc.id}
                  initial={{ opacity: 0, y: 30 }}
                  whileInView={{ opacity: 1, y: 0 }}
                  viewport={{ once: true }}
                  transition={{ duration: 0.6 }}
                  className={`flex flex-col lg:flex-row items-center gap-10 p-8 md:p-12 rounded-3xl glass-panel glass-panel-hover group ${
                    isEven ? '' : 'lg:flex-row-reverse'
                  }`}
                >
                  {/* Service Graphic/Icon Card */}
                  <div className="flex-shrink-0 w-24 h-24 rounded-2xl bg-gradient-to-br from-[var(--neon-blue)]/15 to-[var(--neon-purple)]/10 text-[var(--neon-blue)] flex items-center justify-center group-hover:bg-white group-hover:text-zinc-950 transition-all duration-300 shadow-md">
                    <Icon className="h-10 w-10" />
                  </div>

                  {/* Service Details */}
                  <div className="flex-1 space-y-4 text-left">
                    {svc.isHighlight && (
                      <span className="inline-block text-[10px] font-black tracking-widest text-[var(--neon-blue)] bg-[var(--neon-blue)]/12 rounded px-2.5 py-1">
                        ⭐ FLAGSHIP SERVICE
                      </span>
                    )}
                    <h3 className="text-2xl font-bold text-[var(--text-primary)]">
                      {svc.title}
                    </h3>
                    <p className="text-sm text-[var(--text-secondary)] leading-relaxed">
                      {svc.fullDescription}
                    </p>

                    <div className="flex flex-wrap gap-2 pt-2">
                      {svc.benefits.map((b) => (
                        <span 
                          key={b} 
                          className="text-xs text-[var(--text-secondary)] bg-[var(--neon-purple)]/8 border border-[var(--neon-purple)]/15 rounded-md px-3 py-1.5"
                        >
                          {b}
                        </span>
                      ))}
                    </div>
                  </div>
                </motion.div>
              )
            })}
          </div>
        </div>
      </section>

      {/* --- PROCESS SECTION --- */}
      <section className="w-full py-12 md:py-16 px-6 md:px-20 bg-[var(--background)]">
        <div className="mx-auto max-w-7xl">
          <div className="text-center space-y-4 max-w-3xl mx-auto">
            <div className="inline-block rounded-md border border-[var(--neon-blue)]/20 px-3 py-1 text-xs font-bold text-[var(--neon-blue)] uppercase tracking-wide">
              🚀 OUR PROCESS
            </div>
            <h2 className="text-3xl md:text-5xl font-extrabold leading-tight text-[var(--text-primary)]">
              From Concept to<br />Live Automation
            </h2>
            <p className="text-sm md:text-base text-[var(--text-secondary)]">
              A proven 4-step methodology that delivers working automations in weeks, not months.
            </p>
          </div>

          <div className="mt-16 grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
            {processSteps.map((step, i) => {
              const Icon = step.icon
              return (
                <motion.div
                  key={step.step}
                  initial={{ opacity: 0, y: 20 }}
                  whileInView={{ opacity: 1, y: 0 }}
                  viewport={{ once: true }}
                  transition={{ duration: 0.5, delay: 0.1 * i }}
                  className="flex flex-col text-left p-8 rounded-3xl glass-panel glass-panel-hover group"
                >
                  <span className="text-gradient text-4xl font-extrabold mb-4 leading-none">
                    {step.step}
                  </span>
                  <div className="h-10 w-10 rounded-lg flex items-center justify-center bg-[var(--neon-blue)]/10 text-[var(--neon-blue)] mb-4 group-hover:bg-white group-hover:text-zinc-950 transition-all duration-300">
                    <Icon className="h-5 w-5" />
                  </div>
                  <h3 className="text-lg font-bold text-[var(--text-primary)] mb-2">
                    {step.title}
                  </h3>
                  <p className="text-xs text-[var(--text-secondary)] leading-relaxed">
                    {step.desc}
                  </p>
                </motion.div>
              )
            })}
          </div>
        </div>
      </section>

    </div>
  )
}
