import './globals.css'
import type { Metadata } from 'next'
import { Inter } from 'next/font/google'
import { Footer } from './components/footer'
import Header from './components/header'

const inter = Inter({ subsets: ['latin'] })

export const metadata: Metadata = {
  title: 'Erik Bautista Portfolio | Developer',
  description: 'A passionate software developer who loves to design, build, and deploy products!',
}

export default function RootLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return (
    <html lang="en">
      <body className={`${inter.className} flex flex-col min-h-screen antialiased`}>
        <Header />
        <main className='flex-auto'>{children}</main>
        <Footer />
      </body>
    </html>
  )
}
