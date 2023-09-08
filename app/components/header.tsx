'use client'

import { usePathname } from 'next/navigation'
import Link from 'next/link'
import { FiMenu } from 'react-icons/fi'
import { useState } from 'react'

export default function Header() {
    const pathname = usePathname()
    const [showingMenu, setShowingMenu] = useState(false);

    const eventHandler = () => { 
        setShowingMenu(!showingMenu); 
    };

    const tabs = [
        { title: "home", href: "/" },
        { title: "projects", href: "/projects" },
        { title: "about", href: "/about" }
    ];

    return (
        <header>
            <nav className="flex flex-row">
                <a href="/" className="font-bold text-lg shrink">{'<erik/>'}</a>

                <div className='flex flex-col ml-auto sm:hidden'>
                    <button onClick={eventHandler} className='ml-auto text-xl p-1 rounded-md transition ease-in-out duration-200 hover:bg-neutral-500/20'>
                        <FiMenu />
                    </button>
                    <div className={showingMenu ? 'on-reveal-blur absolute top-[92px] w-full h-full px-8 left-0 flex flex-col gap-2 bg-initial-color z-50 text-neutral-400 ' : 'on-dismiss-blur hidden'}>
                        {tabs.map(tab => <a className={`${pathname == tab.href ? 'bg-neutral-800/50 text-white' : '' } hover:text-white font-medium px-4 p-3 rounded-lg`} key={tab.title} href={tab.href}>{tab.title}</a>)}
                    </div>
                </div>

                <div className="hidden sm:flex text-sm font-medium flex-shrink ml-auto self-center space-x-4 text-neutral-500">
                    {tabs.map(tab => <Link key={tab.title} className={pathname == tab.href ? 'text-white' : ''} href={tab.href}>{tab.title}</Link>)}
                </div>
            </nav>
        </header>
    )
}