USE BookStoreDB;
GO

UPDATE books SET cover_image = 'images/' + title + '.jpg';
GO
