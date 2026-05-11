// lib/data/services/services_data.dart

import 'package:flutter/material.dart';
import '../models/service_model.dart';

class ServicesData {
  static List<ServiceModel> getServices() => [
        const ServiceModel(
          id: 'rpa',
          title: 'Robotic Process Automation',
          shortDescription:
              'Automate repetitive tasks with intelligent software robots that work 24/7.',
          fullDescription:
              'Our RPA solutions deploy intelligent software bots that replicate human actions across digital systems. From data entry to complex workflows, we automate end-to-end processes with precision, speed, and zero errors — freeing your workforce for high-value strategic work.',
          icon: Icons.smart_toy_outlined,
          benefits: [
            '70% reduction in operational costs',
            '10x faster process execution',
            '99.9% accuracy rate',
            '24/7 uninterrupted operation',
            'Seamless legacy system integration',
            'Rapid ROI within 3–6 months',
          ],
          isHighlight: true,
        ),
        const ServiceModel(
          id: 'ai',
          title: 'AI & Machine Learning',
          shortDescription:
              'Harness the power of AI to derive insights, predict outcomes, and automate decisions.',
          fullDescription:
              'We build custom AI and ML models tailored to your industry. From predictive analytics to natural language processing, our intelligent systems learn from data and continuously improve performance.',
          icon: Icons.psychology_outlined,
          benefits: [
            'Predictive analytics dashboards',
            'NLP and sentiment analysis',
            'Computer vision solutions',
            'Anomaly detection systems',
          ],
        ),
        const ServiceModel(
          id: 'mobile',
          title: 'Mobile App Development',
          shortDescription:
              'Native and cross-platform mobile apps for Android & iOS with cutting-edge UX.',
          fullDescription:
              'From concept to deployment, we build high-performance mobile applications using Flutter (cross-platform) and native Swift/Kotlin. Our apps are built for scale, speed, and superior user experience.',
          icon: Icons.phone_android_outlined,
          benefits: [
            'Android & iOS from one codebase',
            'Flutter / React Native',
            'Native Swift & Kotlin',
            'Fintech, healthtech, enterprise apps',
          ],
        ),
        const ServiceModel(
          id: 'web',
          title: 'Web Development',
          shortDescription:
              'Scalable, high-performance web applications built on modern tech stacks.',
          fullDescription:
              'We architect and develop enterprise-grade web platforms using React, Flutter Web, Node.js, and cloud-native infrastructure. Every product we ship is optimised for performance, security, and scale.',
          icon: Icons.language_outlined,
          benefits: [
            'React / Flutter Web / Next.js',
            'REST & GraphQL APIs',
            'Cloud deployment (AWS, GCP, Azure)',
            'SEO & Core Web Vitals optimised',
          ],
        ),
        const ServiceModel(
          id: 'uiux',
          title: 'UI/UX Design',
          shortDescription:
              'Intuitive, research-driven design systems that delight users and drive conversion.',
          fullDescription:
              'Our design team crafts user-centric digital experiences backed by research and data. We build comprehensive design systems, prototypes, and pixel-perfect interfaces that reflect your brand.',
          icon: Icons.design_services_outlined,
          benefits: [
            'User research & wireframing',
            'Figma design systems',
            'Interactive prototyping',
            'Accessibility-first design',
          ],
        ),
      ];
}
