'use client';

import { ReactNode, useEffect, useRef, useState } from 'react';

export const Reveal = ({ children }: { children: ReactNode }) => {
  const [isVisible, setIsVisible] = useState(false);
  const ref = useRef<HTMLDivElement>(null);

  const makeAppear = (entries: any) => {
    const [entry] = entries;
    if (entry.isIntersecting) setIsVisible(true);
  };

  const callBack = makeAppear;

  useEffect(() => {
    const containerRefCurrent = ref.current;
    const observer = new IntersectionObserver(callBack);
    if (containerRefCurrent) observer.observe(containerRefCurrent);

    return () => {
      if (containerRefCurrent) {
        observer.unobserve(containerRefCurrent);
      }
    };
  }, [ref, callBack]);

  return (
    <div
      ref={ref}
      className={
        isVisible ? ' on-reveal-blur opacity-1 duration-200' : 'opacity-0'
      }
    >
      {children}
    </div>
  );
};

export default Reveal;
