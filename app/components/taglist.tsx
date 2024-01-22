export const TagsComponent = ({ tags }: { tags: string[] }) => {
  return (
    <div className="mt-auto flex flex-row flex-wrap gap-1 pt-2  text-xs">
      {tags.map((tag) => (
        <p key={tag} className="blur-view w-fit font-normal">
          {tag}
        </p>
      ))}
    </div>
  );
};
