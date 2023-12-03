import { SiNextdotjs, SiTailwindcss } from 'react-icons/si';
import { Info } from '../utils/userinfo';

export function Footer(
    { info }: { info: Info }
) {
    return (
        <footer className="flex-initial w-full text-sm">
            <div className="border-t pt-8 border-white/10 text-center text-neutral-400 flex flex-col md:flex-row gap-4 items-center">
                <p>© 2023 {info.name}. All Rights Reserved.</p>
                <p className='font-bold gap-2 items-center flex md:ml-auto'>Made With ❤️ &nbsp;Using <SiNextdotjs /> and <SiTailwindcss /></p>
            </div>
        </footer>
    )
}