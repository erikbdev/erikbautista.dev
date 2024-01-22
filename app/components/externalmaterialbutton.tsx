import Link from 'next/link';
import { FiArrowUpRight } from 'react-icons/fi';
import { ExternalLink } from '../utils/allprojects';

export const ExternalLinkButton: React.FC<{
  externalLink: ExternalLink;
  showOpenOn?: boolean;
}> = ({ externalLink, showOpenOn }) => {
  const addOpenOn = showOpenOn ?? false;
  return (
    <Link
      href={externalLink.link}
      target="_blank"
      rel="noopener noreferrer"
      className="blur-view self-center !py-1 text-xs"
    >
      <div className="flex flex-row items-center space-x-1">
        <p>
          {addOpenOn ? 'Open ' : ''}
          {externalLink.deployment}
        </p>
        <FiArrowUpRight className="text-[16px] text-neutral-300" />
      </div>
    </Link>
  );
};
