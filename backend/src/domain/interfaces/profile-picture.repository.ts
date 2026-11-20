import { ProfilePicture } from "../entities/profile-picture.entity.js"

export interface IProfilePictureRepository {
    findByUserId(data: {
        userId: number
    }) : Promise<ProfilePicture | null>;

    create(data: {
        userId: number;
        imageUrl: string;
        imageId: string
    }) : Promise<ProfilePicture>;

    update(data: {
        userId: number;
        imageUrl: string;
        imageId: string;
    }): Promise<ProfilePicture>;

    delete(data: {
        userId: number;
    }): Promise<void>;
}