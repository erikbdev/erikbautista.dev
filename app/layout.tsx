import './globals.css'
import type { Metadata } from 'next'
import { Inter } from 'next/font/google'
import { FiGithub, FiMail } from 'react-icons/fi'
import { Footer } from './components/footer'
import Header from './components/header'

const inter = Inter({ subsets: ['latin'] })

export const metadata: Metadata = {
  title: 'Erik Bautista Portfolio',
  description: 'A passionate software developer!',
}

export default function RootLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return (
    <html lang="en">
      <body className={`${inter.className} flex flex-col antialiased`}>
        <Header />
        {children}
        <Footer />
      </body>
    </html>
  )
}
