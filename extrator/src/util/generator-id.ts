import ShortUniqueId from 'short-unique-id';

const generateUid = (size = 6) => {
  return new ShortUniqueId().randomUUID(size).toLowerCase();
};

export default generateUid;
