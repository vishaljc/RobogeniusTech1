'use client'

import { useState } from 'react'
import { motion, AnimatePresence } from 'framer-motion'
import { 
  Mail, Phone, MapPin, User, Send, CheckCircle2, AlertTriangle, 
  HelpCircle, Shield, Award, Sparkles, Building, Loader2
} from 'lucide-react'
import { Button } from '@/components/ui/button'
import { Card } from '@/components/ui/card'

export default function Contact() {
  const [formData, setFormData] = useState({
    fullName: '',
    email: '',
    mobile: '',
    company: '',
    selectedService: 'Robotic Process Automation',
    message: ''
  })

  const [errors, setErrors] = useState<Record<string, string>>({})
  const [status, setStatus] = useState<'idle' | 'loading' | 'success' | 'error'>('idle')
  const [errorMessage, setErrorMessage] = useState('')

  const services = [
    'Robotic Process Automation',
    'AI & Machine Learning',
    'Mobile App Development',
    'Web Development',
    'UI/UX Design',
  ]

  // Validation
  const validate = () => {
    const newErrors: Record<string, string> = {}
    if (!formData.fullName.trim()) {
      newErrors.fullName = 'Full name is required'
    } else if (formData.fullName.trim().length < 2) {
      newErrors.fullName = 'Name must be at least 2 characters'
    }

    if (!formData.email.trim()) {
      newErrors.email = 'Email address is required'
    } else if (!/^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/.test(formData.email.trim())) {
      newErrors.email = 'Enter a valid email address'
    }

    const digits = formData.mobile.replace(/\D/g, '')
    if (!formData.mobile.trim()) {
      newErrors.mobile = 'Mobile number is required'
    } else if (digits.length !== 10) {
      newErrors.mobile = 'Mobile number must be exactly 10 digits'
    } else if (/^[0-5]/.test(digits)) {
      newErrors.mobile = 'Enter a valid Indian mobile number'
    }

    if (!formData.company.trim()) {
      newErrors.company = 'Company name is required'
    } else if (formData.company.trim().length < 2) {
      newErrors.company = 'Enter a valid company name'
    }

    if (!formData.message.trim()) {
      newErrors.message = 'Message is required'
    } else if (formData.message.trim().length < 10) {
      newErrors.message = 'Message must be at least 10 characters'
    }

    setErrors(newErrors)
    return Object.keys(newErrors).length === 0
  }

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault()
    if (!validate()) return

    setStatus('loading')
    setErrorMessage('')

    try {
      const response = await fetch('/api/contact', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
        body: JSON.stringify({
          full_name: formData.fullName.trim(),
          email: formData.email.trim(),
          mobile: formData.mobile.replace(/\D/g, ''),
          company: formData.company.trim(),
          service: formData.selectedService,
          message: formData.message.trim()
        })
      })

      if (response.ok) {
        setStatus('success')
      } else {
        const resData = await response.json().catch(() => ({}))
        setErrorMessage(resData.message || resData.error || `Server error (${response.status}). Please try again.`)
        setStatus('error')
      }
    } catch (err: any) {
      setErrorMessage(err.message || 'Something went wrong. Please check your network and try again.')
      setStatus('error')
    }
  }

  const resetForm = () => {
    setFormData({
      fullName: '',
      email: '',
      mobile: '',
      company: '',
      selectedService: 'Robotic Process Automation',
      message: ''
    })
    setErrors({})
    setStatus('idle')
    setErrorMessage('')
  }

  return (
    <div className="w-full relative overflow-x-hidden flex flex-col">
      
      {/* --- HERO SECTION --- */}
      <section className="relative w-full py-16 md:py-24 px-6 md:px-20 bg-hero-gradient border-b border-stone-200 dark:border-stone-900">
        <div className="absolute top-[-10%] left-[-10%] h-[350px] w-[350px] rounded-full bg-[var(--primary)]/5 blur-[100px] pointer-events-none" />
        <div className="absolute bottom-[10%] right-[-10%] h-[350px] w-[350px] rounded-full bg-[var(--primary)]/5 blur-[100px] pointer-events-none" />

        <div className="mx-auto max-w-4xl text-center space-y-6 z-10">
          <motion.div 
            initial={{ opacity: 0, scale: 0.95 }}
            animate={{ opacity: 1, scale: 1 }}
            className="inline-flex items-center gap-2 rounded-full border border-[var(--primary)]/20 bg-[var(--primary)]/5 px-4 py-1.5 mx-auto"
          >
            <span className="text-[10px] sm:text-xs font-bold tracking-[0.08em] text-[var(--neon-blue)] uppercase">
              CONTACT US
            </span>
          </motion.div>

          <motion.h1 
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.6, delay: 0.1 }}
            className="text-4xl md:text-6xl font-black font-heading tracking-tight leading-[1.1] text-[var(--text-primary)]"
          >
            Let&apos;s Automate<br />
            <span className="text-gradient">
              Your Business Together
            </span>
          </motion.h1>

          <motion.p 
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.6, delay: 0.2 }}
            className="text-base md:text-lg leading-relaxed text-stone-600 dark:text-stone-400 max-w-2xl mx-auto"
          >
            Schedule a free consultation with our automation experts. We&apos;ll analyse your processes and show you exactly where automation can deliver the most impact.
          </motion.p>
        </div>
      </section>

      {/* --- FORM SECTION --- */}
      <section className="w-full py-16 px-6 md:px-20 bg-[var(--background)]">
        <div className="mx-auto max-w-7xl">
          <div className="grid grid-cols-1 lg:grid-cols-12 gap-12 items-start">
            
            {/* Left Contact Form Card */}
            <motion.div 
              initial={{ opacity: 0, y: 25 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ duration: 0.6 }}
              className="lg:col-span-8 p-8 md:p-10 rounded-3xl glass-panel relative overflow-hidden shadow-2xl border-stone-200 dark:border-stone-800 bg-[var(--card)]"
            >
              <AnimatePresence mode="wait">
                {status === 'success' ? (
                  <motion.div 
                    key="success"
                    initial={{ opacity: 0, scale: 0.95 }}
                    animate={{ opacity: 1, scale: 1 }}
                    exit={{ opacity: 0, scale: 0.95 }}
                    className="text-center py-10 space-y-6"
                  >
                    <div className="mx-auto h-16 w-16 rounded-full bg-button-gradient flex items-center justify-center text-white shadow-lg shadow-[rgba(217,119,6,0.2)]">
                      <CheckCircle2 className="h-8 w-8" />
                    </div>
                    <div className="space-y-2">
                      <h3 className="text-2xl font-extrabold font-heading text-[var(--text-primary)]">Message Sent!</h3>
                      <p className="text-sm text-stone-600 dark:text-stone-400 max-w-md mx-auto leading-relaxed">
                        Our automation experts will reach out within 24 hours with a personalised assessment.
                      </p>
                    </div>
                    <Button onClick={resetForm} className="bg-button-gradient text-white font-bold h-11 px-6">
                      Send another message
                    </Button>
                  </motion.div>
                ) : (
                  <motion.form 
                    key="form"
                    onSubmit={handleSubmit}
                    className="space-y-6 text-left"
                  >
                    <div className="space-y-2">
                      <h3 className="text-xl font-bold font-heading text-[var(--text-primary)]">Get Your Free Automation Assessment</h3>
                      <p className="text-xs text-stone-500 dark:text-stone-400">Fill out the form and we&apos;ll respond within 24 hours.</p>
                    </div>

                    <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                      {/* Name */}
                      <div className="space-y-1.5">
                        <label className="text-xs font-bold text-stone-500">Full Name</label>
                        <div className="relative">
                          <User className="absolute left-3.5 top-3.5 h-4 w-4 text-stone-400" />
                          <input 
                            type="text" 
                            placeholder="John Doe"
                            value={formData.fullName}
                            onChange={(e) => setFormData({ ...formData, fullName: e.target.value })}
                            className={`w-full bg-[var(--background)] border ${errors.fullName ? 'border-red-500/60 focus:ring-red-500/10' : 'border-stone-200 dark:border-stone-850'} hover:border-[var(--primary)]/60 focus:border-[var(--primary)] rounded-xl py-3 pl-11 pr-4 text-sm focus:outline-none focus:ring-1 focus:ring-[var(--primary)]/20 transition-all`}
                          />
                        </div>
                        {errors.fullName && <p className="text-red-500 text-xs mt-1">{errors.fullName}</p>}
                      </div>

                      {/* Email */}
                      <div className="space-y-1.5">
                        <label className="text-xs font-bold text-stone-500">Email Address</label>
                        <div className="relative">
                          <Mail className="absolute left-3.5 top-3.5 h-4 w-4 text-stone-400" />
                          <input 
                            type="email" 
                            placeholder="john@example.com"
                            value={formData.email}
                            onChange={(e) => setFormData({ ...formData, email: e.target.value })}
                            className={`w-full bg-[var(--background)] border ${errors.email ? 'border-red-500/60 focus:ring-red-500/10' : 'border-stone-200 dark:border-stone-850'} hover:border-[var(--primary)]/60 focus:border-[var(--primary)] rounded-xl py-3 pl-11 pr-4 text-sm focus:outline-none focus:ring-1 focus:ring-[var(--primary)]/20 transition-all`}
                          />
                        </div>
                        {errors.email && <p className="text-red-500 text-xs mt-1">{errors.email}</p>}
                      </div>
                    </div>

                    <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                      {/* Mobile */}
                      <div className="space-y-1.5">
                        <label className="text-xs font-bold text-stone-500">Mobile Number</label>
                        <div className="relative">
                          <Phone className="absolute left-3.5 top-3.5 h-4 w-4 text-stone-400" />
                          <input 
                            type="tel" 
                            placeholder="10-digit mobile number"
                            value={formData.mobile}
                            onChange={(e) => setFormData({ ...formData, mobile: e.target.value })}
                            className={`w-full bg-[var(--background)] border ${errors.mobile ? 'border-red-500/60 focus:ring-red-500/10' : 'border-stone-200 dark:border-stone-850'} hover:border-[var(--primary)]/60 focus:border-[var(--primary)] rounded-xl py-3 pl-11 pr-4 text-sm focus:outline-none focus:ring-1 focus:ring-[var(--primary)]/20 transition-all`}
                          />
                        </div>
                        {errors.mobile && <p className="text-red-500 text-xs mt-1">{errors.mobile}</p>}
                      </div>

                      {/* Company */}
                      <div className="space-y-1.5">
                        <label className="text-xs font-bold text-stone-500">Company Name</label>
                        <div className="relative">
                          <Building className="absolute left-3.5 top-3.5 h-4 w-4 text-stone-400" />
                          <input 
                            type="text" 
                            placeholder="Acme Corp"
                            value={formData.company}
                            onChange={(e) => setFormData({ ...formData, company: e.target.value })}
                            className={`w-full bg-[var(--background)] border ${errors.company ? 'border-red-500/60 focus:ring-red-500/10' : 'border-stone-200 dark:border-stone-850'} hover:border-[var(--primary)]/60 focus:border-[var(--primary)] rounded-xl py-3 pl-11 pr-4 text-sm focus:outline-none focus:ring-1 focus:ring-[var(--primary)]/20 transition-all`}
                          />
                        </div>
                        {errors.company && <p className="text-red-500 text-xs mt-1">{errors.company}</p>}
                      </div>
                    </div>

                    {/* Service Dropdown */}
                    <div className="space-y-1.5">
                      <label className="text-xs font-bold text-stone-500">Selected Service</label>
                      <select 
                        value={formData.selectedService}
                        onChange={(e) => setFormData({ ...formData, selectedService: e.target.value })}
                        className="w-full bg-[var(--background)] border border-stone-200 dark:border-stone-850 hover:border-[var(--primary)] focus:border-[var(--primary)] rounded-xl py-3 px-4 text-sm focus:outline-none focus:ring-1 focus:ring-[var(--primary)]/20 transition-all cursor-pointer"
                      >
                        {services.map((svc) => (
                          <option key={svc} value={svc} className="bg-[var(--card)]">{svc}</option>
                        ))}
                      </select>
                    </div>

                    {/* Message */}
                    <div className="space-y-1.5">
                      <label className="text-xs font-bold text-stone-500">Message</label>
                      <textarea 
                        rows={4}
                        placeholder="Tell us about your automation needs..."
                        value={formData.message}
                        onChange={(e) => setFormData({ ...formData, message: e.target.value })}
                        className={`w-full bg-[var(--background)] border ${errors.message ? 'border-red-500/60 focus:ring-red-500/10' : 'border-stone-200 dark:border-stone-850'} hover:border-[var(--primary)]/60 focus:border-[var(--primary)] rounded-xl py-3 px-4 text-sm focus:outline-none focus:ring-1 focus:ring-[var(--primary)]/20 transition-all`}
                      />
                      {errors.message && <p className="text-red-500 text-xs mt-1">{errors.message}</p>}
                    </div>

                    {/* Error message */}
                    {status === 'error' && (
                      <div className="flex gap-2.5 p-4 rounded-xl border border-red-500/30 bg-red-500/10 text-red-500 text-sm">
                        <AlertTriangle className="h-5 w-5 shrink-0" />
                        <div>
                          <h4 className="font-bold">Submission Failed</h4>
                          <p className="text-xs mt-1 opacity-90">{errorMessage}</p>
                        </div>
                      </div>
                    )}

                    <Button 
                      type="submit" 
                      disabled={status === 'loading'}
                      className="w-full bg-[var(--foreground)] text-[var(--background)] hover:bg-[var(--foreground)]/90 font-bold h-12 flex items-center justify-center gap-2 rounded-full cursor-pointer disabled:opacity-80 transition-all hover:scale-[1.01] active:scale-[0.99] shadow-[0_4px_16px_rgba(217,119,6,0.2)]"
                    >
                      {status === 'loading' ? (
                        <>
                          <Loader2 className="h-4.5 w-4.5 animate-spin" />
                          Submitting...
                        </>
                      ) : (
                        <>
                          Send Message & Get Assessment
                          <Send className="h-4 w-4" />
                        </>
                      )}
                    </Button>

                    <p className="text-center text-xs text-stone-400 mt-2">All fields are required</p>
                  </motion.form>
                )}
              </AnimatePresence>
            </motion.div>

            {/* Right Contact Info Details */}
            <motion.div 
              initial={{ opacity: 0, x: 25 }}
              animate={{ opacity: 1, x: 0 }}
              transition={{ duration: 0.6, delay: 0.1 }}
              className="lg:col-span-4 space-y-6"
            >
              {/* Card 1: Email */}
              <div className="p-6 rounded-3xl glass-panel glass-panel-hover flex gap-4 text-left border-stone-200 dark:border-stone-850 bg-[var(--card)] hover:border-[var(--primary)]/30 transition-all duration-300">
                <div className="h-10 w-10 rounded-lg flex items-center justify-center bg-[var(--primary)]/8 text-[var(--neon-blue)] border border-[var(--primary)]/10 shrink-0">
                  <Mail className="h-5 w-5" />
                </div>
                <div className="space-y-1">
                  <h4 className="text-sm font-bold text-[var(--text-primary)]">Email Us</h4>
                  <p className="text-xs text-stone-600 dark:text-stone-400 break-all">info@robogeniustech.co.in</p>
                </div>
              </div>

              {/* Card 1.5: Sales */}
              <div className="p-6 rounded-3xl glass-panel glass-panel-hover flex gap-4 text-left border-stone-200 dark:border-stone-850 bg-[var(--card)] hover:border-[var(--primary)]/30 transition-all duration-300">
                <div className="h-10 w-10 rounded-lg flex items-center justify-center bg-[var(--primary)]/8 text-[var(--neon-blue)] border border-[var(--primary)]/10 shrink-0">
                  <Mail className="h-5 w-5" />
                </div>
                <div className="space-y-1">
                  <h4 className="text-sm font-bold text-[var(--text-primary)]">Sales</h4>
                  <p className="text-xs text-stone-600 dark:text-stone-400 break-all">Sales@robogeniustech.co.in</p>
                </div>
              </div>

              {/* Card 2: Support */}
              <div className="p-6 rounded-3xl glass-panel glass-panel-hover flex gap-4 text-left border-stone-200 dark:border-stone-850 bg-[var(--card)] hover:border-[var(--primary)]/30 transition-all duration-300">
                <div className="h-10 w-10 rounded-lg flex items-center justify-center bg-[var(--primary)]/8 text-[var(--neon-blue)] border border-[var(--primary)]/10 shrink-0">
                  <Shield className="h-5 w-5" />
                </div>
                <div className="space-y-1">
                  <h4 className="text-sm font-bold text-[var(--text-primary)]">For Support</h4>
                  <p className="text-xs text-stone-600 dark:text-stone-400 break-all">support@robogeniustech.co.in</p>
                </div>
              </div>

              {/* Card 3: Call */}
              <div className="p-6 rounded-3xl glass-panel glass-panel-hover flex gap-4 text-left border-stone-200 dark:border-stone-850 bg-[var(--card)] hover:border-[var(--primary)]/30 transition-all duration-300">
                <div className="h-10 w-10 rounded-lg flex items-center justify-center bg-[var(--primary)]/8 text-[var(--neon-blue)] border border-[var(--primary)]/10 shrink-0">
                  <Phone className="h-5 w-5" />
                </div>
                <div className="space-y-1">
                  <h4 className="text-sm font-bold text-[var(--text-primary)]">Call Us</h4>
                  <p className="text-xs text-stone-600 dark:text-stone-400">+91 89283 82034</p>
                </div>
              </div>

              {/* Card 4: Address */}
              <div className="p-6 rounded-3xl glass-panel glass-panel-hover flex gap-4 text-left border-stone-200 dark:border-stone-850 bg-[var(--card)] hover:border-[var(--primary)]/30 transition-all duration-300">
                <div className="h-10 w-10 rounded-lg flex items-center justify-center bg-[var(--primary)]/8 text-[var(--neon-blue)] border border-[var(--primary)]/10 shrink-0">
                  <MapPin className="h-5 w-5" />
                </div>
                <div className="space-y-1">
                  <h4 className="text-sm font-bold text-[var(--text-primary)]">Our Office</h4>
                  <p className="text-xs text-stone-600 dark:text-stone-400 whitespace-pre-line">Mumbai, Maharashtra{"\n"}India</p>
                </div>
              </div>

              {/* Trust Panel Info */}
              <div className="p-6 rounded-3xl glass-panel text-left space-y-3.5 border-t border-t-[var(--primary)]/30 border-stone-200 dark:border-stone-850 bg-[var(--card)] hover:bg-white/[0.04] dark:hover:bg-white/[0.04] transition-all duration-300">
                <div className="flex items-center gap-2 text-[var(--neon-blue)] font-bold text-xs">
                  <Sparkles className="h-4 w-4" />
                  <span>Personalised Assessment includes:</span>
                </div>
                <ul className="text-xs text-stone-600 dark:text-stone-400 space-y-2 pl-4 list-disc leading-relaxed">
                  <li>Detailed process bottleneck analysis</li>
                  <li>Estimated development hours & ROI timeline</li>
                  <li>Custom UI/UX prototype overview</li>
                  <li>Post-launch support SLA blueprint</li>
                </ul>
              </div>
            </motion.div>

          </div>
        </div>
      </section>

    </div>
  )
}
