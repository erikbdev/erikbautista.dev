'use client'

// From: https://www.codiga.io/blog/creating-gradient-animations-with-react-canvas-css/

import { useEffect, useRef } from "react";

const SPEED = 0.0;

export const Background = ({ classNames = '' }: { classNames: string }) => {
    const canvasRef = useRef<HTMLCanvasElement>(null);

    useEffect(() => {
        const canvas = canvasRef.current;

        if (canvas) {
            const ctx = canvas.getContext("2d");

            let time = 0;

            const loop = function () {
                for (let x = 0; x <= canvas.width; x++) {
                    for (let y = 0; y <= canvas.height; y++) {
                        color(ctx, {
                            x,
                            y,
                            r: R(x, y, time),
                            g: G(x, y, time),
                            b: B(x, y, time),
                        });
                    }
                }

                time = time + SPEED;

                window.requestAnimationFrame(loop);
            };

            loop();
        }
    }, []);

    return <canvas className={classNames} ref={canvasRef} />;
};

export const color = (context: CanvasRenderingContext2D | null, { x, y, r, g, b }: { x: number, y: number, r: number, g: number, b: number }) => {
    if (context) {
        context.fillStyle = `rgb(${r}, ${g}, ${b})`;
        context.fillRect(x, y, 1, 1);
    }
};

const C1 = 191;
const C2 = 64;

export const R = (x: number, y: number, time: number) => {
    return Math.floor(C1 + C2 * Math.cos((x * x - y * y) / 300 + time));
};

export const G = (x: number, y: number, time: number) => {
    return Math.floor(
        C1 +
        C2 *
        Math.sin(
            (x * x * Math.cos(time / 4) + y * y * Math.sin(time / 3)) / 300
        )
    );
};

export const B = (x: number, y: number, time: number) => {
    return Math.floor(
        C1 +
        C2 *
        Math.sin(
            5 * Math.sin(time / 9) +
            ((x - 100) * (x - 100) + (y - 100) * (y - 100)) / 1100
        )
    );
};
