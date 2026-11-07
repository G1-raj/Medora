export interface ITokenRepository {
    saveToken(data: {
        userId: number;
        refreshToken: string;
    }) : Promise<void>;
}