import Image from 'next/image'
import { Footer } from './components/footer'

export default function Home() {
  return (
    <main>
      <div className='container mx-auto md:grid md:grid-cols-2 md:gap-8 p-20 h-screen content-center'>
        {/* Name */}
        <div className='self-center'>
          <p className='font-semibold text-3xl md:text-4xl'>Erik Bautista Santibanez</p>
          <p className='my-2 text-lg text-gray-300'>iOS Developer and Software Engineer</p>
        </div>
        <div className='self-center w-fill'>
          <div className='flex flex-col'>
            { ActionButton() }
            { ActionButton() }
          </div>
        </div>
      </div>
      {/* Footer
      { Footer() } */}
    </main>
  )
}

function ActionButton() {
  return (
    <div className='my-2 w-fill bg-neutral-400 h-24'>
      <p>Title 1</p>
      <p>Some description</p>
    </div>
  )
}