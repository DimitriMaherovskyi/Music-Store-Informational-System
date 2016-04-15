using MusicShop.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MusicShop.Repositories
{
    /// <summary>
    /// Operations with user
    /// </summary>
    
    // IP: інтерфейси бажано робити як "public"
    interface IUserRepository
    {
        User GetUserByLogin(string login, string password);

        void InitUser(int id);

        void DeauthUser(int id);
    }
}
