import { headers } from "next/headers";

export type Info = {
  name: string,
  short: string,
  email: string
}
  
export async function getUserInfo() {  
    const selfInfo: Info = {
    name: "Erik Bautista Santibanez",
    short: "erik",
    email: "erikbautista15@gmail.com"
    }

    const aliasInfo: Info = {
        name: "ErrorErrorError",
        short: "error",
        email: "contact@errorerrorerror.dev"
    }

    const headersList = headers();

    if (headersList.get('host')?.includes("erik") ?? false) {
      return selfInfo;
    }  else {
      return aliasInfo;
    }  
}