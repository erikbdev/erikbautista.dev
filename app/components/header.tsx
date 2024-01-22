'use client';

import { usePathname } from 'next/navigation';
import Link from 'next/link';
import { FiMenu, FiX } from 'react-icons/fi';
import { useState } from 'react';
import { Info } from '../utils/userinfo';
import { Project } from '../utils/allprojects';
import style from './header.module.css';

type BaseTab = {
  title: string;
  href?: string;
};

type BasicTab = {
  href: string;
} & BaseTab;

type ExpandableTab = {
  subtabs: BasicTab[];
} & BaseTab;

type Tab = BasicTab | ExpandableTab;

export default function Header({
  info,
  projects,
}: {
  info: Info;
  projects: Project[];
}) {
  const pathname = usePathname() || '/';
  const [showingMenu, setShowingMenu] = useState(false);

  const eventHandler = () => {
    setShowingMenu(!showingMenu);
  };

  const tabSelected = (tab: Tab): boolean => {
    if (tab.title == tabs[0].title) {
      return tab.href == pathname;
    } else {
      if ('subtabs' in tab) {
        return tab.subtabs.map((p) => p.href).includes(pathname);
      } else {
        return pathname.includes(tab.href ?? 'none');
      }
    }
  };

  const tabs: Tab[] = [
    { title: 'Home', href: '/' },
    {
      title: 'Case Studies',
      href: undefined,
      subtabs: projects.map((p) => ({ title: p.title, href: p.href })),
    },
  ];

  return (
    <header className="z-50">
      <nav className="flex flex-row">
        <a
          href="/"
          className="shrink text-lg font-bold"
        >{`<${info.short}/>`}</a>

        <div className="ml-auto flex flex-col sm:hidden">
          <button
            onClick={eventHandler}
            className="ml-auto rounded-md p-1 text-xl transition duration-200 ease-in-out hover:bg-neutral-500/20"
          >
            {showingMenu ? <FiX /> : <FiMenu />}
          </button>

          <div className={`${showingMenu ? 'inline' : 'hidden'}`}>
            <ul className={`bg-initial-color space-y-2 ${style['nav-mobile']}`}>
              {tabs.map((t) => (
                <BuildTabLink
                  key={t.title}
                  tab={t}
                  selected={tabSelected}
                  handleClick={eventHandler}
                />
              ))}
            </ul>
          </div>
        </div>

        <ul className={style['nav-desktop']}>
          {tabs.map((t) => (
            <BuildTabLink key={t.title} tab={t} selected={tabSelected} />
          ))}
        </ul>
      </nav>
    </header>
  );
}

const BuildTabLink = ({
  tab,
  selected,
  handleClick,
}: {
  tab: Tab;
  selected: { (tab: Tab): boolean };
  handleClick?: { (): void };
}) => {
  const selectedTagClass = selected(tab) ? style['nav-item-selected'] : '';

  const TagTitle = ({ t }: { t: Tab }) => {
    return (
      <Link
        onClick={() => {
          if (t.href) handleClick?.();
        }}
        className={selectedTagClass}
        key={tab.title}
        href={t.href ?? ''}
      >
        {tab.title}
      </Link>
    );
  };

  if ('subtabs' in tab) {
    return (
      <li className="space-y-2 sm:space-y-0">
        <TagTitle t={tab} />
        <ul className="space-y-2 sm:space-y-1">
          {tab.subtabs.map((t) => (
            <BuildTabLink
              key={t.title}
              tab={t}
              selected={selected}
              handleClick={handleClick}
            />
          ))}
        </ul>
      </li>
    );
  } else {
    return (
      <li>
        <TagTitle t={tab} />
      </li>
    );
  }
};
