"use client";

import { usePathname } from "next/navigation";
import Link from "next/link";
import { FiMenu, FiX } from "react-icons/fi";
import { useState } from "react";
import { Info } from "../utils/userinfo";

export default function Header({ info }: { info: Info }) {
  const pathname = usePathname() || "/";
  const [showingMenu, setShowingMenu] = useState(false);

  const eventHandler = () => {
    setShowingMenu(!showingMenu);
  };

  const tabSelected = (tab: string): boolean => {
    if (tab == tabs[0].href) {
      return tab == pathname
    } else {
      return pathname.includes(tab);
    }
  };

  const tabs = [
    { title: "home", href: "/" },
    { title: "projects", href: "/projects" },
    // { title: "about", href: "/about" }
  ];

  return (
    <header className="z-50">
      <nav className="flex flex-row">
        <a
          href="/"
          className="font-bold text-lg shrink"
        >{`<${info.short}/>`}</a>

        <div className="flex flex-col ml-auto sm:hidden">
          <button
            onClick={eventHandler}
            className="ml-auto text-xl p-1 rounded-md transition ease-in-out duration-200 hover:bg-neutral-500/20"
          >
            {showingMenu ? <FiX /> : <FiMenu />}
          </button>

          <div
            className={`${
              showingMenu ? "header-menu-reveal" : "header-menu-dismiss"
            } absolute top-[92px] left-0 w-full h-full`}
          >
            <div className="header-reveal flex flex-col gap-2 p-8 bg-initial-color text-neutral-400 border-t-[0.15rem] border-neutral-500/20">
              {tabs.map((tab) => (
                <Link
                  onClick={eventHandler}
                  key={tab.title}
                  className={`${
                    tabSelected(tab.href) ? "bg-neutral-800/50 text-white" : ""
                  } hover:text-white font-medium px-4 p-3 rounded-lg`}
                  href={tab.href}
                >
                  {tab.title}
                </Link>
              ))}
            </div>
          </div>
        </div>

        <div className="hidden sm:flex text-sm font-medium flex-shrink ml-auto self-center space-x-4 text-neutral-500">
          {tabs.map((tab) => (
            <Link
              key={tab.title}
              className={tabSelected(tab.href) ? "text-white" : ""}
              href={tab.href}
            >
              {tab.title}
            </Link>
          ))}
        </div>
      </nav>
    </header>
  );
}
