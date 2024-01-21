import { SiNextdotjs, SiTailwindcss } from 'react-icons/si';
import { HiOutlineExternalLink } from 'react-icons/hi';
import { Info } from '../utils/userinfo';

export function Footer({ info }: { info: Info }) {
  return (
    <footer className="max-w-center-layout mt-auto w-full flex-initial text-xs">
      <div className="flex flex-col items-center gap-4 border-t border-neutral-500/20 pt-8 text-center font-semibold text-neutral-400 md:flex-row">
        <p className="flex flex-wrap justify-center gap-1">
          Designed and developed by
          <a
            className="flex items-center gap-1 font-bold md:ml-auto"
            href="https://errorerrorerror.dev"
          >
            {info.name} <HiOutlineExternalLink />
          </a>
        </p>
        <p className="flex flex-wrap items-center  justify-center gap-2 md:ml-auto">
          Made With ❤️ &nbsp;Using{' '}
          <a
            target="_blank"
            rel="noopener noreferrer"
            href="https://nextjs.org/"
          >
            <SiNextdotjs />
          </a>
          and
          <a
            target="_blank"
            rel="noopener noreferrer"
            href="https://tailwindcss.com/"
          >
            <SiTailwindcss />
          </a>
        </p>
      </div>
    </footer>
  );
}
