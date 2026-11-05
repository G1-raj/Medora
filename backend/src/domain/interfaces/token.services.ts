export interface ITokenService {
    generateAccessToken(payload: {
        userId: string,
        email: string,
        role: string
    }): string;
}