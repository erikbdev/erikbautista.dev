import './globals.css'
import { headers } from 'next/headers';
import type { Metadata, ResolvingMetadata } from 'next'
import { Inter } from 'next/font/google'
import { Footer } from './components/footer'
import Header from './components/header'
import { getUserInfo } from './utils/userinfo';

const inter = Inter({ subsets: ['latin'] })

export async function generateMetadata(
  parent: ResolvingMetadata,
): Promise<Metadata> {
  const info = await getUserInfo();

  return {
    title: `${info.name}'s Portfolio | Developer`,
    description: 'A passionate software developer who loves to design, develop, and deploy products!',
    robots: "noindex, nofollow"  
  }
}

export default async function RootLayout(
  { children }: { 
    children: React.ReactNode
  }
) {
  const info = await getUserInfo();
  return (
    <html lang="en">
      <body className={`${inter.className} min-h-screen p-8 antialiased`}>
        <div className='h-full flex flex-col max-w-2xl mx-auto gap-8'>
          <Header info={info} />
          <main className='h-full flex-auto'>{children}</main>
          <Footer info={info} />
        </div>
      </body>
    </html>
  )
}