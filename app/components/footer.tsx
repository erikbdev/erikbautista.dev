import { SiNextdotjs, SiTailwindcss } from 'react-icons/si';
import { AiFillHeart } from 'react-icons/ai';

export function Footer() {
    return (
        <footer className="w-full flex-initial text-sm p-8">
            <div className="screen-container border-t pt-8 border-white/10 text-center text-neutral-400 flex flex-col sm:flex-row gap-4 items-center">
                <p>© 2023 Erik Bautista Santibanez. All Rights Reserved.</p>
                <p className='font-bold gap-2 items-center flex sm:ml-auto'>Crafted With ❤️ Using <SiNextdotjs /> and <SiTailwindcss /></p>
            </div>
        </footer>
    )
}