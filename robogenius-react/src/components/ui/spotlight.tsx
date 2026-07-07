import React from "react";
import { cn } from "@/lib/utils";

type SpotlightProps = {
  className?: string;
  fill?: string;
};

export const Spotlight = ({ className, fill }: SpotlightProps) => {
  return (
    <div
      className={cn(
        "animate-spotlight pointer-events-none absolute z-[1] h-[169%] w-[138%] lg:w-[84%] opacity-0",
        className
      )}
      style={{
        background: `radial-gradient(circle at 50% 0%, ${fill || "rgba(255, 255, 255, 0.12)"} 0%, transparent 75%)`,
        mixBlendMode: "screen",
        willChange: "transform, opacity",
      }}
    />
  );
};
