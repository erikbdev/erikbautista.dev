import { FiGithub, FiMail } from "react-icons/fi";

export default function Header() {
    return (
        <header className="on-reveal-blur flex-initial p-8">
            <div className="screen-container ">
                <p className='font-semibold text-2xl'>Erik Bautista Santibanez</p>
                <p className='text-md text-neutral-400 pb-4'>iOS Developer & Software Engineer</p>
                <div className='flex flex-row text-neutral-200 space-x-2 text-2xl'>
                    <a href='mailto:erikbautista15@gmail.com'><FiMail /></a>
                    <a href='https://github.com/ErrorErrorError'><FiGithub /></a>
                </div>
            </div>
        </header>
    )
}