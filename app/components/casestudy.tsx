import Image, { StaticImageData } from "next/image";

export type ImageContent = {
  image: StaticImageData;
  alt: string;
};

export enum ImageOrientation {
  Portrait,
  Landscape
};

export const CaseStudy = ({
  projectName,
  projectDescription,
  images,
  orientation
}: {
  projectName: string;
  projectDescription: string;
  images: ImageContent[];
  orientation: ImageOrientation
}) => {
  return (
    <div className="flex flex-col gap-6">
      <div className="flex flex-col sm:flex-row gap-8">
        <div className="w-full flex flex-col sm:self-center">
          <p className="font-bold text-3xl">{projectName}</p>
          <p className="text-lg font-semibold pt-1">Case Study</p>
          <p className="pt-4">{projectDescription}</p>
        </div>
      </div>

      <hr className="opacity-10"></hr>

      <div className="flex flex-col gap-4">
        <p className="text-2xl font-bold">Screenshots</p>
        <div className={"grid grid-cols-1" + (orientation == ImageOrientation.Landscape ? "" : " sm:grid-cols-2 gap-4 md:grid-cols-3")}>
          {images.map((p) => (
            <Image
              key={p.alt}
              className="w-full rounded-3xl"
              src={p.image}
              alt={p.alt}
            />
          ))}
        </div>
      </div>
    </div>
  );
};
