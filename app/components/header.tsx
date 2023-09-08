'use client'

import { usePathname } from 'next/navigation'
import Link from 'next/link'

interface NavigationTab {
    title: string,
    href: string
}

const tabs: NavigationTab[] = [
    { title: "home", href: "/" },
    { title: "projects", href: "/projects" },
    { title: "about", href: "/about" },
]

export default function Header() {
    const pathname = usePathname()

    return (
        <header>
            <nav className="flex flex-row">
                <a href="/" className="font-bold text-lg text-center shrink">{'<erik/>'}</a>
                <div className="text-sm font-medium flex-shrink ml-auto self-center space-x-4 text-neutral-500">
                    {tabs.map(tab => <Link className={pathname == tab.href ? 'text-white' : '' } href={tab.href}>{tab.title}</Link>)}
                </div>
            </nav>
        </header>
    )
}