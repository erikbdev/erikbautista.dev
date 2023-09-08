import './globals.css'
import type { Metadata } from 'next'
import { Inter } from 'next/font/google'
import { Footer } from './components/footer'
import Header from './components/header'

const inter = Inter({ subsets: ['latin'] })

export const metadata: Metadata = {
  title: 'Erik Bautista Portfolio | Developer',
  description: 'A passionate software developer who loves to design, develop, and deploy products!',
}

export default function RootLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return (
    <html lang="en">
      <body className={`${inter.className} min-h-screen p-8 antialiased`}>
        <div className='h-full flex flex-col max-w-2xl mx-auto gap-8'>
          <Header />
          <main className='h-full flex-auto'>{children}</main>
          <Footer />
        </div>
      </body>
    </html>
  )
}
