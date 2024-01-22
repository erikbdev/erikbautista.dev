'use client';
import React, {
  PropsWithChildren,
  useCallback,
  useEffect,
  useMemo,
  useState,
} from 'react';
import { useRef } from 'react';

type Size = {
  width: number;
  height: number;
};

export type RGB = {
  r: number;
  g: number;
  b: number;
};

export const BGGradientAnimation: React.FC<
  PropsWithChildren<{
    colors: RGB[];
    className?: string;
    canvasClassName?: string;
  }>
> = ({ colors, className, children, canvasClassName }) => {
  const elementRef = useRef<HTMLDivElement | null>(null);
  const canvasRef = useRef<HTMLCanvasElement | null>(null);
  const frameRef = useRef(0);

  const [size, setSize] = useState<Size>({ width: 200, height: 200 });

  const particles = useMemo(() => {
    const totalParticles = 12;

    const items: Particle[] = [];

    const maxRadius = 600;
    const minRadius = 300;
    let currentColor = 0;

    for (let i = 0; i < totalParticles; i++) {
      if (!colors[currentColor]) continue;

      const particle = new Particle(
        Math.random() * size.width,
        Math.random() * size.height,
        Math.random() * (maxRadius - minRadius) + minRadius,
        colors[currentColor]
      );

      if (++currentColor >= colors.length) currentColor = 0;

      items.push(particle);
    }

    return items;
  }, [colors]);

  const animateParticles = useCallback(
    (size: Size) => {
      if (!canvasRef.current) return;
      const ctx = canvasRef.current.getContext('2d');
      if (!ctx) return;

      const pixelRatio = window.devicePixelRatio > 1 ? 2 : 1;
      ctx.clearRect(0, 0, canvasRef.current.width, canvasRef.current.height);
      ctx.scale(pixelRatio, pixelRatio);
      ctx.globalCompositeOperation = 'saturation';

      for (const particle of particles) {
        particle.animate(ctx, size);
      }

      frameRef.current = requestAnimationFrame(() => animateParticles(size));
    },
    [particles]
  );

  useEffect(() => {
    if (frameRef.current) cancelAnimationFrame(frameRef.current);
    frameRef.current = requestAnimationFrame(() => animateParticles(size));
    return () => cancelAnimationFrame(frameRef.current);
  }, [animateParticles, size]);

  const observer = useMemo(() => {
    return new ResizeObserver((e) => {
      setSize({
        width: e[0].target.getBoundingClientRect().width,
        height: e[0].target.getBoundingClientRect().height,
      });
    });
  }, []);

  const sizeRef = useCallback(
    (node: HTMLDivElement | null) => {
      if (node === null) {
        if (elementRef.current) {
          observer.unobserve(elementRef.current);
          elementRef.current = null;
        }
      } else {
        elementRef.current = node;
        observer.observe(node);
      }
    },
    [observer]
  );

  return (
    <div className={className} ref={sizeRef}>
      <canvas
        width={size.width}
        height={size.height}
        className={`absolute z-0 ${canvasClassName ?? ''}`}
        ref={canvasRef}
      ></canvas>
      {children}
    </div>
  );
};

class Particle {
  x: number;
  y: number;
  radius: number;
  rgb: RGB;

  private vx: number;
  private vy: number;
  private sinValue: number;

  constructor(x: number, y: number, radius: number, rgb: RGB) {
    this.x = x;
    this.y = y;
    this.radius = radius;
    this.rgb = rgb;
    this.vx = Math.random() * 0.4 * (Math.random() < 0.5 ? 1 : -1);
    this.vy = Math.random() * 0.4 * (Math.random() < 0.5 ? 1 : -1);
    this.sinValue = Math.random();
  }

  animate = (ctx: CanvasRenderingContext2D, size: Size): void => {
    this.sinValue += 0.008;
    this.radius += Math.sin(this.sinValue);
    this.x += this.vx;
    this.y += this.vy;

    if (this.x < 0) {
      this.vx *= -1;
      this.x += this.vx;
    } else if (this.x > size.width) {
      this.vx *= -1;
      this.x += this.vx;
    }

    if (this.y < 0) {
      this.vy *= -1;
      this.y += this.vy;
    } else if (this.y > size.height) {
      this.vy *= -1;
      this.y += this.vy;
    }

    ctx.beginPath();

    const g = ctx.createRadialGradient(
      this.x,
      this.y,
      Math.max(this.radius, 0) * 0.01,
      this.x,
      this.y,
      Math.max(this.radius, 0)
    );

    g.addColorStop(0, `rgba(${this.rgb.r}, ${this.rgb.g}, ${this.rgb.b}, 1)`);
    g.addColorStop(1, `rgba(${this.rgb.r}, ${this.rgb.g}, ${this.rgb.b}, 0)`);

    ctx.fillStyle = g;
    ctx.arc(this.x, this.y, Math.max(this.radius, 0), 0, Math.PI * 2);
    ctx.fill();
  };
}
