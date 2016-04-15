using MusicShop.Entities;
using System.Collections.Generic;

namespace MusicShop.Repositories
{
    // IP: інтерфейси бажано робити як "public"
    // + відсутній коментар ...
    interface IShopStorageRepository
    {
        List<AlbumsInStorage> SelectAll();
        List<AlbumsInStorage> SelectByGenre(int genreId);
    }
}

