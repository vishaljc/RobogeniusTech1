'use client'

import { useEffect, useState } from 'react'

interface SplineSceneProps {
  scene?: string // Optional now, since we use SVG
  className?: string
  onLoad?: () => void
}

export function SplineScene({ onLoad }: SplineSceneProps) {
  const [mounted, setMounted] = useState(false)
  const [animate, setAnimate] = useState(false)
  const [mousePos, setMousePos] = useState({ x: 0, y: 0 })

  useEffect(() => {
    setMounted(true)
    
    // Trigger onload after 1 second delay to allow text center animations first,
    // then slide text left and fade in the robot graphic
    const timer = setTimeout(() => {
      setAnimate(true)
      if (onLoad) onLoad()
    }, 1000)

    const handleMouseMove = (e: MouseEvent) => {
      // Normalize cursor coordinate relative to viewport center (-1 to 1)
      const cx = (e.clientX / window.innerWidth) * 2 - 1
      const cy = (e.clientY / window.innerHeight) * 2 - 1
      
      // Limit eye movement range to max 3.5px horizontally, 2.5px vertically
      const tx = cx * 3.5
      const ty = cy * 2.5
      
      setMousePos({ x: tx, y: ty })
    }

    window.addEventListener('mousemove', handleMouseMove)

    return () => {
      clearTimeout(timer)
      window.removeEventListener('mousemove', handleMouseMove)
    }
  }, [onLoad])

  if (!mounted) return null

  return (
    <div 
      className={`w-full h-full flex items-center justify-center relative overflow-hidden transition-all duration-1000 ease-out ${
        animate ? 'opacity-100 scale-100' : 'opacity-0 scale-95'
      }`}
      style={{ willChange: 'opacity, transform' }}
    >
      <svg
        className="w-[85%] h-[85%] max-w-[550px] max-h-[550px]"
        viewBox="0 0 200 200"
        fill="none"
        xmlns="http://www.w3.org/2000/svg"
      >
        <defs>
          {/* Glowing filters */}
          <filter id="eyeGlow" x="-20%" y="-20%" width="140%" height="140%">
            <feGaussianBlur stdDeviation="3" result="blur" />
            <feComposite in="SourceGraphic" in2="blur" operator="over" />
          </filter>
          
          <filter id="robotGlow" x="-20%" y="-20%" width="140%" height="140%">
            <feGaussianBlur stdDeviation="10" result="blur" />
            <feComposite in="SourceGraphic" in2="blur" operator="over" />
          </filter>

          {/* Gradients */}
          {/* Brand amber glow */}
          <radialGradient id="bgGlow" cx="50%" cy="50%" r="50%">
            <stop offset="0%" stopColor="#f59e0b" stopOpacity="0.25" />
            <stop offset="100%" stopColor="#f59e0b" stopOpacity="0" />
          </radialGradient>
          
          {/* Metallic helmet gradient (black/dark grey gloss) */}
          <linearGradient id="helmetGrad" x1="0%" y1="0%" x2="100%" y2="100%">
            <stop offset="0%" stopColor="#2e2a24" />
            <stop offset="40%" stopColor="#171513" />
            <stop offset="100%" stopColor="#0b0a09" />
          </linearGradient>

          {/* Glass faceplate gradient */}
          <linearGradient id="faceplateGrad" x1="0%" y1="0%" x2="0%" y2="100%">
            <stop offset="0%" stopColor="#1a1816" />
            <stop offset="100%" stopColor="#090807" />
          </linearGradient>

          {/* Glossy reflection highlight */}
          <linearGradient id="glossGrad" x1="0%" y1="0%" x2="0%" y2="100%">
            <stop offset="0%" stopColor="#faf9f6" stopOpacity="0.15" />
            <stop offset="50%" stopColor="#faf9f6" stopOpacity="0.02" />
            <stop offset="100%" stopColor="#faf9f6" stopOpacity="0" />
          </linearGradient>

          <linearGradient id="shoulderGrad" x1="0%" y1="0%" x2="100%" y2="0%">
            <stop offset="0%" stopColor="#0b0a09" />
            <stop offset="50%" stopColor="#24211e" />
            <stop offset="100%" stopColor="#0b0a09" />
          </linearGradient>
        </defs>

        {/* CSS styles for floating and blinking */}
        <style>{`
          .robot-float {
            animation: float 6s ease-in-out infinite;
          }
          .eye-blink {
            animation: blink 5s infinite;
          }
          .circuit-pulse {
            animation: pulse-glow 3s ease-in-out infinite;
          }
          
          @keyframes float {
            0%, 100% { transform: translateY(0px) rotate(0deg); }
            50% { transform: translateY(-8px) rotate(0.5deg); }
          }
          @keyframes blink {
            0%, 96%, 100% { opacity: 1; }
            98% { opacity: 0; }
          }
          @keyframes pulse-glow {
            0%, 100% { opacity: 0.2; }
            50% { opacity: 0.6; }
          }
        `}</style>

        {/* Ambient background glow */}
        <circle cx="100" cy="90" r="75" fill="url(#bgGlow)" className="circuit-pulse" />

        {/* Decorative background HUD elements */}
        <g stroke="#f59e0b" strokeOpacity="0.15" strokeWidth="0.75" className="robot-float">
          {/* Tech circle orbit */}
          <circle cx="100" cy="90" r="68" strokeDasharray="3 8" />
          <path d="M 100,22 A 68,68 0 0,1 168,90" strokeOpacity="0.3" strokeWidth="1.2" />
          <path d="M 32,90 A 68,68 0 0,1 100,158" strokeOpacity="0.3" strokeWidth="1.2" />
        </g>

        {/* --- ROBOT BUST GROUP (FLOATING) --- */}
        <g className="robot-float" style={{ transformOrigin: '100px 90px' }}>
          
          {/* Neck Connections / Pistons */}
          <rect x="94" y="125" width="12" height="20" rx="1" fill="#1c1917" stroke="#f59e0b" strokeWidth="0.5" strokeOpacity="0.3" />
          <line x1="97" y1="125" x2="97" y2="145" stroke="#f59e0b" strokeWidth="1" strokeOpacity="0.6" />
          <line x1="103" y1="125" x2="103" y2="145" stroke="#f59e0b" strokeWidth="1" strokeOpacity="0.6" />

          {/* Shoulders & Chest Plates */}
          <path
            d="M 50,145 C 50,145 60,138 100,138 C 140,138 150,145 150,145 C 162,154 168,172 168,172 L 32,172 C 32,172 38,154 50,145 Z"
            fill="url(#shoulderGrad)"
            stroke="#f59e0b"
            strokeWidth="1.2"
            strokeOpacity="0.4"
          />

          {/* Collar/Base joints */}
          <ellipse cx="100" cy="138" rx="22" ry="5" fill="#0c0a09" stroke="#f59e0b" strokeWidth="0.75" strokeOpacity="0.3" />

          {/* Helmet/Outer Head (Sleek dark shield) */}
          <path
            d="M 100,45 C 68,45 65,65 65,95 C 65,115 74,130 100,130 C 126,130 135,115 135,95 C 135,65 132,45 100,45 Z"
            fill="url(#helmetGrad)"
            stroke="#f59e0b"
            strokeWidth="1.5"
            strokeOpacity="0.6"
            filter="url(#eyeGlow)"
          />

          {/* Inner Faceplate (Glossy black shield) */}
          <path
            d="M 100,53 C 74,53 71,70 71,93 C 71,110 79,122 100,122 C 121,122 129,110 129,93 C 129,70 126,53 100,53 Z"
            fill="url(#faceplateGrad)"
          />

          {/* --- Glowing Grid Eyes (Tracks Mouse Cursor) --- */}
          <g 
            className="eye-blink" 
            style={{ 
              transform: `translate(${mousePos.x}px, ${mousePos.y}px)`,
              transition: 'transform 0.1s ease-out',
              transformOrigin: '100px 85px' 
            }}
          >
            {/* Left Eye Grid */}
            <g fill="#faf9f6" filter="url(#eyeGlow)" opacity="0.95">
              <circle cx="86" cy="83" r="1" />
              <circle cx="90" cy="83" r="1" />
              <circle cx="84" cy="86" r="1" />
              <circle cx="88" cy="86" r="1" />
              <circle cx="92" cy="86" r="1" />
              <circle cx="86" cy="89" r="1" />
              <circle cx="90" cy="89" r="1" />
            </g>

            {/* Right Eye Grid */}
            <g fill="#faf9f6" filter="url(#eyeGlow)" opacity="0.95">
              <circle cx="110" cy="83" r="1" />
              <circle cx="114" cy="83" r="1" />
              <circle cx="108" cy="86" r="1" />
              <circle cx="112" cy="86" r="1" />
              <circle cx="116" cy="86" r="1" />
              <circle cx="110" cy="89" r="1" />
              <circle cx="114" cy="89" r="1" />
            </g>
          </g>

          {/* Helmet Glass Reflection Highlight (Gives the 3D look) */}
          <path
            d="M 73,85 C 73,70 78,57 100,57 C 122,57 127,70 127,85 C 127,75 120,62 100,62 C 80,62 73,75 73,85 Z"
            fill="url(#glossGrad)"
          />
        </g>
      </svg>
    </div>
  )
}
