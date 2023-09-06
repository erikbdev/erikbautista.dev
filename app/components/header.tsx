import { FiGithub, FiMail } from "react-icons/fi";

export default function Header() {
    return (
        <header className="on-reveal-blur flex-initial container py-8">
            <p className='font-semibold text-lg md:text-2xl'>Erik Bautista Santibanez</p>
            <p className='text-sm md:text-md text-neutral-400 pb-4'>iOS Developer & Software Engineer</p>
            <div className='flex flex-row text-neutral-200 space-x-3 text-lg md:text-2xl'>
                <a href='mailto:erikbautista15@gmail.com'><FiMail /></a>
                <a href='https://github.com/ErrorErrorError'><FiGithub /></a>
            </div>
        </header>
    )
}